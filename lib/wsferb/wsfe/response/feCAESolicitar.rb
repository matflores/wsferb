#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FECAESolicitar < Response
      def result
        response[:fecae_solicitar_response][:fecae_solicitar_result] rescue {}
      end

      def formatted_records
        return [] unless success?

        Lote.from_hash(result, :fe_cab_resp, :fe_det_resp, :fecae_det_response).to_s.split("\n")
      end
    end
  end
end
