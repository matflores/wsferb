# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FECompConsultar < Response
      def result
        response[:fe_comp_consultar_response][:fe_comp_consultar_result] rescue {}
      end

      def formatted_records
        return [] unless success?

        "10001\n#{Cbte.from_hash(result[:result_get]).to_s}".split("\n")
      end
    end
  end
end
