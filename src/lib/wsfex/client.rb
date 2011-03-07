#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'time'
require 'wsaa'

Savon.configure do |config|
  config.log = false            # disable logging
 # config.log_level = :info      # changing the log level
 # config.logger = Rails.logger  # using the Rails logger
end

#Savon::SOAP::DateTimeRegexp = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$/

HTTPI.log       = false     # disabling logging
#HTTPI.logger    = MyLogger  # changing the logger
#HTTPI.log_level = :info     # changing the log level

module WSFEX

  class Client < AFIP::Client

    WSDL = File.dirname(__FILE__) + '/wsfex.wsdl'
    PROD_URL = 'https://servicios1.afip.gov.ar/wsfex/service.asmx'
    TEST_URL = 'https://wswhomo.afip.gov.ar/wsfex/service.asmx'

    def self.authorize(ticket, entrada, salida, log_file=nil)
      return ticket_missing if ticket.nil?

      fex = WSFEX::Fex.from_file(entrada)
      response = with_driver(:log => log_file) do |driver|
        driver.fEXAuthorize(ticket_to_arg(ticket).merge({ :Cmp => fex.to_hash.dup }))
      end

      errCode = response.fEXAuthorizeResult.fEXErr.errCode.to_i rescue -1

      if errCode == 0 && response.respond_to?(:fEXAuthorizeResult) && response.fEXAuthorizeResult.respond_to?(:fEXResultAuth)
        result = response.fEXAuthorizeResult.fEXResultAuth

        fex.cae             = result.cae
        fex.fecha_cae       = result.fch_cbte
        fex.fecha_vto_cae   = result.fch_venc_Cae
        fex.resultado       = result.resultado

        fex.to_file(salida)
      end

      return WSFEX::Response.new(response, :fEXAuthorizeResult, :cae, :fEXResultAuth)
    end

    def self.checkPermiso(ticket, permiso, pais, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_check_permiso) do
        soap.body = ticket_to_arg(ticket).merge({ "ID_Permiso" => permiso.dup, "Dst_merc" => pais.dup })
      end
      return WSFEX::Response.new(response, :fex_check_permiso_response, :fex_check_permiso_result, :status)
    end

    def self.getCmp(ticket, tipoCbte, puntoVta, nroCbte, salida, log_file=nil)
      return ticket_missing if ticket.nil?

      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_cmp) do
        soap.body = ticket_to_arg(ticket).merge({ "Cmp" => { "Tipo_cbte" => tipoCbte.dup, "Punto_vta" => puntoVta.dup, "Cbte_nro" => nroCbte.dup }})
      end
      return WSFEX::Response.new(response, :fex_check_permiso_response, :fex_check_permiso_result, :status)

      response = response.to_hash
      errCode = response[:fex_get_cmp_response][:fex_get_cmp_result][:fex_err][:err_code].to_i rescue -1

      if errCode == 0 && response.has_key?(:fex_get_cmp_response) && response[:fex_get_cmp_response][:fex_get_cmp_result]
        result = response[:fex_get_cmp_response][:fex_get_cmp_result][:fex_result_get]

        fex                 = WSFEX::Fex.new

        fex.id_cbte         = result[:id]
        fex.tipo_cbte       = result[:tipo_cbte]
        fex.punto_vta       = result[:punto_vta]
        fex.nro_cbte        = result[:cbte_nro]
        fex.fecha_cbte      = result[:fecha_cbte]
        fex.tipo_expo       = result[:tipo_expo]
        fex.tiene_permiso   = result[:permiso_existente]
        fex.pais            = result[:dst_cmp]
        fex.cuit_pais       = result[:cuit_pais_cliente]
        fex.id_impositivo   = result[:id_impositivo]
        fex.cliente         = result[:cliente]
        fex.domicilio       = result[:domicilio_cliente]
        fex.moneda          = result[:moneda_id]
        fex.cotizacion      = result[:moneda_ctz]
        fex.total           = result[:imp_total]
        fex.forma_pago      = result[:forma_pago]
        fex.idioma          = result[:idioma_cbte]
        fex.incoterms       = result[:incoterms]
        fex.incoterms_info  = result[:incoterms_ds]
        fex.cae             = result[:cae]
        fex.fecha_cae       = result[:fecha_cbte]
        fex.fecha_vto_cae   = result[:fch_venc_cae]
        fex.resultado       = result[:resultado]
        fex.obs             = result[:obs]
        fex.obs_comerciales = result[:obs_comerciales]

        result[:permisos][:permiso].each do |permiso|
          if permiso.has_key?(:id_permiso) &&
             permiso.has_key?(:dst_merc)

            fex.permisos << { :id_permiso => permiso[:id_permiso],
                              :dst_merc   => permiso[:dst_merc] }

          end
        end if result.has_key?(:permisos)

        result[:cmps_asoc][:cmp_asoc].each do |comprobante|
          if comprobante.has_key?(:cbte_tipo)      &&
             comprobante.has_key?(:cbte_punto_vta) &&
             comprobante.has_key?(:cbte_nro)

            fex.comprobantes << { :cbte_tipo      => comprobante[:cbte_tipo],
                                  :cbte_punto_vta => comprobante[:cbte_punto_vta],
                                  :cbte_nro       => comprobante[:cbte_nro] }
          end
        end if result.has_key?(:cmps_asoc)

        result[:items][:item].each do |item|
          if item.has_key?(:pro_codigo)     &&
             item.has_key?(:pro_ds)         &&
             item.has_key?(:pro_qty)        &&
             item.has_key?(:pro_umed)       &&
             item.has_key?(:pro_precio_uni) &&
             item.has_key?(:pro_total_item)

            fex.items << { :pro_codigo      => item[:pro_codigo],
                           :pro_ds          => item[:pro_ds],
                           :pro_qty         => item[:pro_qty],
                           :pro_umed        => item[:pro_umed],
                           :pro_precio_uni  => item[:pro_precio_uni],
                           :pro_total_item  => item[:pro_total_item] }
          end
        end if result.has_key?(:items)

        fex.to_file(salida)
      end

      return WSFEX::Response.new(response, :fex_get_cmp_response, :fex_get_cmp_result, :cae)
    end

    def self.getLastCmp(ticket, tipoCbte, puntoVta, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_last_cmp) do
        soap.body = { "Auth" => { "Token"     => ticket.token.dup,
                                  "Sign"      => ticket.sign.dup,
                                  "Cuit"      => ticket.cuit.dup,
                                  "Pto_venta" => puntoVta.dup,
                                  "Tipo_cbte" => tipoCbte.dup } }
      end
      return WSFEX::Response.new(response, :fex_get_last_cmp_response, :fex_get_last_cmp_result, :cbte_nro, :fex_result_last_cmp)
    end

    def self.getLastId(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_last_id) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response.new(response, :fex_get_last_id_response, :fex_get_last_id_result, :id)
    end

    def self.getParamCtz(ticket, moneda, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_ctz) do
        soap.body = ticket_to_arg(ticket).merge({ :mon_id => moneda })
      end
      return WSFEX::Response.new(response, :fex_get_param_ctz_response, :fex_get_param_ctz_result, :mon_ctz)
    end

    def self.getParamDstCuit(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_dst_cuit) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response::GetParamDstCuit.new(response, :fex_get_param_dst_cuit_response, :fex_get_param_dst_cuit_result)
    end

    def self.getParamDstPais(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_dst_pais) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response::GetParamDstPais.new(response, :fex_get_param_dst_pais_response, :fex_get_param_dst_pais_result)
    end

    def self.getParamIdiomas(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_idiomas) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response::GetParamIdiomas.new(response, :fex_get_param_idiomas_response, :fex_get_param_idiomas_result)
    end

    def self.getParamIncoterms(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_incoterms) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response::GetParamIncoterms.new(response, :fex_get_param_incoterms_response, :fex_get_param_incoterms_result)
    end

    def self.getParamMon(ticket, log_file=nil)
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_mon) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response::GetParamMon.new(response, :fex_get_param_mon_response, :fex_get_param_mon_result)
    end

    def self.getParamPtoVenta(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_pto_venta) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response::GetParamPtoVenta.new(response, :fex_get_param_pto_venta_response, :fex_get_param_pto_venta_result)
    end

    def self.getParamTipoCbte(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_tipo_cbte) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response::GetParamTipoCbte.new(response, :fex_get_param_tipo_cbte_response, :fex_get_param_tipo_cbte_result)
    end

    def self.getParamTipoExpo(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_tipo_expo) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response::GetParamTipoExpo.new(response, :fex_get_param_tipo_expo_response, :fex_get_param_tipo_expo_result)
    end

    def self.getParamUMed(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:n1, :fex_get_param_u_med) do
        soap.body = ticket_to_arg(ticket)
      end
      return WSFEX::Response::GetParamUMed.new(response, :fex_get_param_u_med_response, :fex_get_param_u_med_result)
    end

    def self.test(log_file=nil)
      response = with_driver(:log => log_file) do |driver|
        driver.fEXDummy(nil)
      end

      client = Savon::Client.new
      client.wsdl.document = self::WSDL
      client.wsdl.endpoint = self::TEST_URL
      response = client.request(:fex_dummy)
      "authserver=#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:auth_server]}; appserver=#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:app_server]}; dbserver=#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:db_server]};"
    end

    def self.ticket_missing
      WSFEX::Response.new(nil, :nil, nil)
    end

    def self.ticket_to_arg(ticket)
      return { "Auth" => { "Token" => ticket.token, "Sign" => ticket.sign, "Cuit" => ticket.cuit } }
    end
  end

end
