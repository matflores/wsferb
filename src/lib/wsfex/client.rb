#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
require "time"
require "wsaa"

Savon.configure do |config|
  config.log = true            # disable logging
 # config.log_level = :info      # changing the log level
 # config.logger = Rails.logger  # using the Rails logger
end

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

      response = client.request(:n1, :fex_authorize) do
        soap.body = ticket_to_arg(ticket).merge({ "Cmp" => fex.to_hash.dup })
      end

      WSFEX::Response::FEXAuthorize.new(response).tap do |response|
        puts "*************"
        puts response.response.inspect
        puts "*************"
        if response.success?
          fex.cae           = response.info[:cae]
          fex.fecha_cae     = response.info[:fch_cbte]
          fex.fecha_vto_cae = response.info[:fch_venc_cae]
          fex.resultado     = response.info[:resultado]

          fex.to_file(salida)
        end
      end
    end

    def self.checkPermiso(ticket, permiso, pais, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_check_permiso) do
        soap.body = ticket_to_arg(ticket).merge({ "ID_Permiso" => permiso.dup, "Dst_merc" => pais.dup })
      end

      return WSFEX::Response::FEXCheckPermiso.new(response)
    end

    def self.getCmp(ticket, tipoCbte, puntoVta, nroCbte, salida, log_file=nil)
      return ticket_missing if ticket.nil?

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

      response = client.request(:n1, :fex_get_last_cmp) do
        soap.body = { "Auth" => { "Token"     => ticket.token.dup,
                                  "Sign"      => ticket.sign.dup,
                                  "Cuit"      => ticket.cuit.dup,
                                  "Pto_venta" => puntoVta.dup,
                                  "Tipo_cbte" => tipoCbte.dup } }
      end

      return WSFEX::Response::FEXGetLastCmp.new(response)
    end

    def self.getLastId(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_last_id) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetLastId.new(response)
    end

    def self.getParamCtz(ticket, moneda, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_ctz) do
        soap.body = ticket_to_arg(ticket).merge({ :mon_id => moneda })
      end

      return WSFEX::Response::FEXGetParamCtz.new(response)
    end

    def self.getParamDstCuit(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_dst_cuit) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetParamDstCuit.new(response)
    end

    def self.getParamDstPais(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_dst_pais) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetParamDstPais.new(response)
    end

    def self.getParamIdiomas(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_idiomas) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetParamIdiomas.new(response)
    end

    def self.getParamIncoterms(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_incoterms) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetParamIncoterms.new(response)
    end

    def self.getParamMon(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_mon) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetParamMon.new(response)
    end

    def self.getParamPtoVenta(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_pto_venta) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetParamPtoVenta.new(response)
    end

    def self.getParamTipoCbte(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_tipo_cbte) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetParamTipoCbte.new(response)
    end

    def self.getParamTipoExpo(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_tipo_expo) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetParamTipoExpo.new(response)
    end

    def self.getParamUMed(ticket, log_file=nil)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fex_get_param_u_med) do
        soap.body = ticket_to_arg(ticket)
      end

      return WSFEX::Response::FEXGetParamUMed.new(response)
    end

    def self.test(log_file=nil)
      response = client.request(:fex_dummy)
      "authserver=#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:auth_server]}; appserver=#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:app_server]}; dbserver=#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:db_server]};"
    end

    def self.ticket_missing
      WSFEX::Response.new(nil, :nil, nil)
    end

    def self.ticket_to_arg(ticket)
      return { "Auth" => { "Token" => ticket.token, "Sign" => ticket.sign, "Cuit" => ticket.cuit } }
    end

    def self.client
      @client ||= Savon::Client.new do |wsdl, http|
        wsdl.document = WSFEX::Client::WSDL
        wsdl.endpoint = WSFEX::Client::TEST_URL
      end
    end
  end
end
