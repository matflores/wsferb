# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FECompUltimoAutorizado < Response
      def format_record(record)
        "1%08d" % [ record[:cbte_nro] ]
      end

      def records
        @records ||= [ result ]
      end

      def result
        response[:fe_comp_ultimo_autorizado_response][:fe_comp_ultimo_autorizado_result] rescue {}
      end
    end
  end
end
