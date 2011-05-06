#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "time"
require "savon"

module WSFErb
  module WSFE
    class Client
      def self.fe_caea_consultar(ticket, periodo, quincena)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fecaea_consultar) do
          soap.body = ticket.to_hash.merge({ "Periodo" => periodo.dup, "Orden" => quincena.dup })
        end

        return Response::FECAEAConsultar.new(response)
      end

      def self.fe_caea_reg_informativo(ticket, lote)
        raise TicketMissing unless ticket

        lote = Lote.load(lote)

        response = client.request(:n1, :fecaea_reg_informativo) do
          soap.body = ticket.to_hash.merge({ "FeCAEARegInfReq" => lote.to_hash.stringify_keys })
        end

        return Response::FECAEARegInformativo.new(response)
      end

      def self.fe_caea_sin_movimiento_consultar(ticket, caea, punto_vta)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fecaea_sin_movimiento_consultar) do
          soap.body = ticket.to_hash.merge({ "CAEA" => caea.dup, "PtoVta" => punto_vta.dup })
        end

        return Response::FECAEASinMovimientoConsultar.new(response)
      end

      def self.fe_caea_sin_movimiento_informar(ticket, caea, punto_vta)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fecaea_sin_movimiento_informar) do
          soap.body = ticket.to_hash.merge({ "CAEA" => caea.dup, "PtoVta" => punto_vta.dup })
        end

        return Response::FECAEASinMovimientoInformar.new(response)
      end

      def self.fe_caea_solicitar(ticket, periodo, quincena)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fecaea_solicitar) do
          soap.body = ticket.to_hash.merge({ "Periodo" => periodo.dup, "Orden" => quincena.dup })
        end

        return Response::FECAEASolicitar.new(response)
      end

      def self.fe_cae_solicitar(ticket, lote)
        raise TicketMissing unless ticket

        lote = Lote.load(lote)

        response = client.request(:n1, :fe_cae_solicitar) do
          soap.body = ticket.to_hash.merge({ "FeCAEReq" => lote.to_hash.stringify_keys })
        end

        return Response::FECAESolicitar.new(response)
      end

      def self.fe_comp_consultar(ticket, tipo_cbte, punto_vta, nro_cbte)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_comp_consultar) do
          soap.body = ticket.to_hash.merge({ "FeCompConsReq" => { "CbteTipo" => tipo_cbte.dup, "PtoVta" => punto_vta.dup, "CbteNro" => nro_cbte.dup }})
        end

        return Response::FECompConsultar.new(response)
      end

      def self.fe_comp_tot_x_request(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_comp_tot_x_request) do
          soap.body = ticket.to_hash
        end

        return Response::FECompTotXRequest.new(response)
      end

      def self.fe_comp_ultimo_autorizado(ticket, tipo_cbte, punto_vta)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_comp_ultimo_autorizado) do
          soap.body = ticket.to_hash.merge({ "CbteTipo" => tipo_cbte.dup, "PtoVta" => punto_vta.dup })
        end

        return Response::FECompUltimoAutorizado.new(response)
      end

      def self.fe_dummy
        response = client.request(:fe_dummy)
        "1#{response.to_hash[:fe_dummy_response][:fe_dummy_result][:auth_server]}#{response.to_hash[:fe_dummy_response][:fe_dummy_result][:app_server]}#{response.to_hash[:fe_dummy_response][:fe_dummy_result][:db_server]}"
      end

      def self.fe_param_get_cotizacion(ticket, moneda)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_param_get_cotizacion) do
          soap.body = ticket.to_hash.merge({ "MonId" => moneda.dup })
        end

        return Response::FEParamGetCotizacion.new(response)
      end

      def self.fe_param_get_ptos_venta(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_param_get_ptos_venta) do
          soap.body = ticket.to_hash
        end

        return Response::FEParamGetPtosVenta.new(response)
      end

      def self.fe_param_get_tipos_cbte(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_param_get_tipos_cbte) do
          soap.body = ticket.to_hash
        end

        return Response::FEParamGetTiposCbte.new(response)
      end

      def self.fe_param_get_tipos_concepto(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_param_get_tipos_concepto) do
          soap.body = ticket.to_hash
        end

        return Response::FEParamGetTiposConcepto.new(response)
      end

      def self.fe_param_get_tipos_doc(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_param_get_tipos_doc) do
          soap.body = ticket.to_hash
        end

        return Response::FEParamGetTiposDoc.new(response)
      end

      def self.fe_param_get_tipos_iva(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_param_get_tipos_iva) do
          soap.body = ticket.to_hash
        end

        return Response::FEParamGetTiposIva.new(response)
      end

      def self.fe_param_get_tipos_monedas(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_param_get_tipos_monedas) do
          soap.body = ticket.to_hash
        end

        return Response::FEParamGetTiposMonedas.new(response)
      end

      def self.fe_param_get_tipos_opcional(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_param_get_tipos_opcional) do
          soap.body = ticket.to_hash
        end

        return Response::FEParamGetTiposOpcional.new(response)
      end

      def self.fe_param_get_tipos_tributos(ticket)
        raise TicketMissing unless ticket

        response = client.request(:n1, :fe_param_get_tipos_tributos) do
          soap.body = ticket.to_hash
        end

        return Response::FEParamGetTiposTributos.new(response)
      end

      def self.client
        options = { :wsdl           => File.join(File.dirname(__FILE__), "/wsfev1.wsdl"),
                    :production_url => "https://servicios1.afip.gov.ar/wsfev1/service.asmx",
                    :testing_url    => "https://wswhomo.afip.gov.ar/wsfev1/service.asmx" }

        @client ||= WSFErb.client(options)
      end
    end
  end
end
