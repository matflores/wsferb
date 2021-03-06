#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "time"
require "savon"

module WSFErb
  module WSFEX
    class Client
      def self.fex_authorize(ticket, cbte)
        raise TicketMissing unless ticket

        fex = Fex.load(cbte)

        response = client.request(:n1, :fex_authorize) do
          soap.body = ticket.to_hash.merge({ "Cmp" => fex.to_hash.stringify_keys })
        end

        response = Response::FEXAuthorize.new(response)

        response.success? ? fex_get_cmp(ticket, fex.tipo_cbte, fex.punto_vta, fex.nro_cbte) : response
      end

      def self.fex_check_permiso(ticket, permiso, pais)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_check_permiso) do
          soap.body = ticket.to_hash.merge({ "ID_Permiso" => permiso.dup, "Dst_merc" => pais.dup })
        end

        Response::FEXCheckPermiso.new(response)
      end

      def self.fex_dummy
        response = client.request(:fex_dummy)
        "1#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:auth_server]}#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:app_server]}#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:db_server]}"
      end

      def self.fex_get_cmp(ticket, tipo_cbte, punto_vta, nro_cbte)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_cmp) do
          soap.body = ticket.to_hash.merge({ "Cmp" => { "Tipo_cbte" => tipo_cbte, "Punto_vta" => punto_vta, "Cbte_nro" => nro_cbte }})
        end

        Response::FEXGetCmp.new(response)
      end

      def self.fex_get_last_cmp(ticket, tipo_cbte, punto_vta)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_last_cmp) do
          soap.body = { "Auth" => { "Token"     => ticket.token.dup,
                                    "Sign"      => ticket.sign.dup,
                                    "Cuit"      => ticket.cuit.dup,
                                    "Pto_venta" => punto_vta.dup,
                                    "Tipo_cbte" => tipo_cbte.dup } }
        end

        Response::FEXGetLastCmp.new(response)
      end

      def self.fex_get_last_id(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_last_id) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetLastId.new(response)
      end

      def self.fex_get_param_ctz(ticket, moneda)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_ctz) do
          soap.body = ticket.to_hash.merge({ "Mon_id" => moneda })
        end

        Response::FEXGetParamCtz.new(response)
      end

      def self.fex_get_param_dst_cuit(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_dst_cuit) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetParamDstCuit.new(response)
      end

      def self.fex_get_param_dst_pais(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_dst_pais) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetParamDstPais.new(response)
      end

      def self.fex_get_param_idiomas(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_idiomas) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetParamIdiomas.new(response)
      end

      def self.fex_get_param_incoterms(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_incoterms) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetParamIncoterms.new(response)
      end

      def self.fex_get_param_mon(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_mon) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetParamMon.new(response)
      end

      def self.fex_get_param_pto_venta(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_pto_venta) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetParamPtoVenta.new(response)
      end

      def self.fex_get_param_tipo_cbte(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_tipo_cbte) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetParamTipoCbte.new(response)
      end

      def self.fex_get_param_tipo_expo(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_tipo_expo) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetParamTipoExpo.new(response)
      end

      def self.fex_get_param_u_med(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fex_get_param_u_med) do
          soap.body = ticket.to_hash
        end

        Response::FEXGetParamUMed.new(response)
      end

      def self.client
        options = { :wsdl           => File.join(File.dirname(__FILE__), "/wsfex.wsdl"),
                    :production_url => "https://servicios1.afip.gov.ar/wsfex/service.asmx",
                    :testing_url    => "https://wswhomo.afip.gov.ar/wsfex/service.asmx" }

        @client ||= WSFErb.client(options)
      end
    end
  end
end
