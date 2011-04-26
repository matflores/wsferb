# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FECompUltimoAutorizado < Response
      def formatted_records
        records.map { |record| format_record(record) }
      end

      def format_record(record)
        [ "1%03d%04d%08d" % [ result[:cbte_tipo], result[:pto_vta], result[:cbte_nro] ] ]
      end

      def records
        @records ||= [result]
      end

      def value
        result[:cbte_nro] rescue "n/d"
      end

      def result
        response[:fe_comp_ultimo_autorizado_response][:fe_comp_ultimo_autorizado_result] rescue {}
      end
    end
  end
end
