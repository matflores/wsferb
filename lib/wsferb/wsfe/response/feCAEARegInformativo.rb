#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FECAEARegInformativo < Response
      def result
        response[:fecaea_reg_informativo_response][:fecaea_reg_informativo_result] rescue {}
      end

      def formatted_records
        return [] unless success?

        Lote.from_hash(result).to_s
      end
    end
  end
end
