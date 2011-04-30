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
        return ticket_missing if ticket.nil?

        fex = Fex.from_file(cbte)

        response = client.request(:n1, :fex_authorize) do
          soap.body = ticket_to_arg(ticket).merge({ :Cmp => fex.to_hash.stringify_keys })
        end

        response = Response::FEXAuthorize.new(response)

        response.success? ? fex_get_cmp(ticket, fex.tipo_cbte, fex.punto_vta, fex.nro_cbte) : response
      end

      def self.fex_check_permiso(ticket, permiso, pais)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_check_permiso) do
          soap.body = ticket_to_arg(ticket).merge({ "ID_Permiso" => permiso.dup, "Dst_merc" => pais.dup })
        end

        return Response::FEXCheckPermiso.new(response)
      end

      def self.fex_get_cmp(ticket, tipo_cbte, punto_vta, nro_cbte)
        puts "info for #{tipo_cbte}-#{punto_vta}-#{nro_cbte}"
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_cmp) do
          soap.body = ticket_to_arg(ticket).merge({ "Cmp" => { "Tipo_cbte" => tipo_cbte, "Punto_vta" => punto_vta, "Cbte_nro" => nro_cbte }})
        end

        Response::FEXGetCmp.new(response)
      end

      def self.fex_get_last_cmp(ticket, tipo_cbte, punto_vta)
        return ticket_missing if ticket.nil?

        response = client.request(:n1, :fex_get_last_cmp) do
          soap.body = { "Auth" => { "Token"     => ticket.token.dup,
                                    "Sign"      => ticket.sign.dup,
                                    "Cuit"      => ticket.cuit.dup,
                                    "Pto_venta" => punto_vta.dup,
                                    "Tipo_cbte" => tipo_cbte.dup } }
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
        "1#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:auth_server]}#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:app_server]}#{response.to_hash[:fex_dummy_response][:fex_dummy_result][:db_server]}"
      end

      def self.ticket_missing
        Response.new(nil, :nil, nil)
      end

      def self.ticket_to_arg(ticket)
        return { :Auth => { :Token => ticket.token, :Sign => ticket.sign, :Cuit => ticket.cuit } }
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
