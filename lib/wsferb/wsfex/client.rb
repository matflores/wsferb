#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "time"
require "savon"

module WSFErb
  module WSFEX
    class Client
      WSDL = File.join(File.dirname(__FILE__), "/wsfex.wsdl")
      PROD_URL = "https://servicios1.afip.gov.ar/wsfex/service.asmx"
      TEST_URL = "https://wswhomo.afip.gov.ar/wsfex/service.asmx"

      @@test_mode_enabled = false

      def self.enable_test_mode
        @@test_mode_enabled = true
      end

      def self.disable_test_mode
        @@test_mode_enabled = false
      end

      def self.test_mode_enabled?
        @@test_mode_enabled
      end

      def self.fex_authorize(ticket, entrada, salida)
        return ticket_missing if ticket.nil?

        fex = Fex.from_file(entrada)

        response = client.request(:n1, :fex_authorize) do
          soap.body = ticket_to_arg(ticket).merge({ :Cmp => fex.to_hash.stringify_keys })
        end

        Response::FEXAuthorize.new(response).tap do |response|
          if response.success?
            fex.cae           = response.info[:cae]
            fex.fecha_cae     = response.info[:fch_cbte]
            fex.fecha_vto_cae = response.info[:fch_venc_cae]
            fex.resultado     = response.info[:resultado]

            fex.to_file(salida)
          end
        end
      end

      def self.fex_check_permiso(ticket, permiso, pais)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_check_permiso) do
          soap.body = ticket_to_arg(ticket).merge({ "ID_Permiso" => permiso.dup, "Dst_merc" => pais.dup })
        end

        return Response::FEXCheckPermiso.new(response)
      end

      def self.fex_get_cmp(ticket, tipoCbte, puntoVta, nroCbte, salida)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_cmp) do
          soap.body = ticket_to_arg(ticket).merge({ "Cmp" => { "Tipo_cbte" => tipoCbte.dup, "Punto_vta" => puntoVta.dup, "Cbte_nro" => nroCbte.dup }})
        end

        Response::FEXGetCmp.new(response).tap do |response|
          if response.success?
            fex                 = Fex.new
            fex.id_cbte         = response.info[:id]
            fex.tipo_cbte       = response.info[:tipo_cbte]
            fex.punto_vta       = response.info[:punto_vta]
            fex.nro_cbte        = response.info[:cbte_nro]
            fex.fecha_cbte      = response.info[:fecha_cbte]
            fex.tipo_expo       = response.info[:tipo_expo]
            fex.tiene_permiso   = response.info[:permiso_existente]
            fex.pais            = response.info[:dst_cmp]
            fex.cuit_pais       = response.info[:cuit_pais_cliente]
            fex.id_impositivo   = response.info[:id_impositivo]
            fex.cliente         = response.info[:cliente]
            fex.domicilio       = response.info[:domicilio_cliente]
            fex.moneda          = response.info[:moneda_id]
            fex.cotizacion      = response.info[:moneda_ctz]
            fex.total           = response.info[:imp_total]
            fex.forma_pago      = response.info[:forma_pago]
            fex.idioma          = response.info[:idioma_cbte]
            fex.incoterms       = response.info[:incoterms]
            fex.incoterms_info  = response.info[:incoterms_ds]
            fex.cae             = response.info[:cae]
            fex.fecha_cae       = response.info[:fecha_cbte]
            fex.fecha_vto_cae   = response.info[:fch_venc_cae]
            fex.resultado       = response.info[:resultado]
            fex.obs             = response.info[:obs]
            fex.obs_comerciales = response.info[:obs_comerciales]

            response.info[:permisos][:permiso].each do |permiso|
              if permiso.has_key?(:id_permiso) &&
                 permiso.has_key?(:dst_merc)

                fex.permisos << { :id_permiso => permiso[:id_permiso],
                                  :dst_merc   => permiso[:dst_merc] }

              end
            end if response.info.has_key?(:permisos)

            response.info[:cmps_asoc][:cmp_asoc].each do |comprobante|
              if comprobante.has_key?(:cbte_tipo)      &&
                 comprobante.has_key?(:cbte_punto_vta) &&
                 comprobante.has_key?(:cbte_nro)

                fex.comprobantes << { :cbte_tipo      => comprobante[:cbte_tipo],
                                      :cbte_punto_vta => comprobante[:cbte_punto_vta],
                                      :cbte_nro       => comprobante[:cbte_nro] }
              end
            end if response.info.has_key?(:cmps_asoc)

            response.info[:items][:item].each do |item|
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
            end if response.info.has_key?(:items)

            fex.to_file(salida)
          end
        end
      end

      def self.fex_get_last_cmp(ticket, tipoCbte, puntoVta)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_last_cmp) do
          soap.body = { "Auth" => { "Token"     => ticket.token.dup,
                                    "Sign"      => ticket.sign.dup,
                                    "Cuit"      => ticket.cuit.dup,
                                    "Pto_venta" => puntoVta.dup,
                                    "Tipo_cbte" => tipoCbte.dup } }
        end

        return Response::FEXGetLastCmp.new(response)
      end

      def self.fex_get_last_id(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_last_id) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetLastId.new(response)
      end

      def self.fex_get_param_ctz(ticket, moneda)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_ctz) do
          soap.body = ticket_to_arg(ticket).merge({ :mon_id => moneda })
        end

        return Response::FEXGetParamCtz.new(response)
      end

      def self.fex_get_param_dst_cuit(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_dst_cuit) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetParamDstCuit.new(response)
      end

      def self.fex_get_param_dst_pais(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_dst_pais) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetParamDstPais.new(response)
      end

      def self.fex_get_param_idiomas(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_idiomas) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetParamIdiomas.new(response)
      end

      def self.fex_get_param_incoterms(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_incoterms) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetParamIncoterms.new(response)
      end

      def self.fex_get_param_mon(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_mon) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetParamMon.new(response)
      end

      def self.fex_get_param_pto_venta(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_pto_venta) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetParamPtoVenta.new(response)
      end

      def self.fex_get_param_tipo_cbte(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_tipo_cbte) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetParamTipoCbte.new(response)
      end

      def self.fex_get_param_tipo_expo(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_tipo_expo) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetParamTipoExpo.new(response)
      end

      def self.fex_get_param_u_med(ticket)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_param_u_med) do
          soap.body = ticket_to_arg(ticket)
        end

        return Response::FEXGetParamUMed.new(response)
      end

      def self.fex_dummy
        response = client.request(:fex_dummy)
        "authserver=#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:auth_server]}; appserver=#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:app_server]}; dbserver=#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:db_server]};"
      end

      def self.ticket_missing
        Response.new(nil, :nil, nil)
      end

      def self.ticket_to_arg(ticket)
        return { :Auth => { :Token => ticket.token, :Sign => ticket.sign, :Cuit => ticket.cuit } }
      end

      def self.client
        @client ||= Savon::Client.new do |wsdl, http|
          wsdl.document = WSDL
          wsdl.endpoint = test_mode_enabled? ? TEST_URL : PROD_URL
        end
      end
    end
  end
end
