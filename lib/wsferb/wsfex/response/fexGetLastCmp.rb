#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetLastCmp < Response
      def format_record(record)
        "1%08d" % [ record[:cbte_nro] ]
      end

      def records
        [ result[:fex_result_last_cmp] ] rescue []
      end

      def result
        response[:fex_get_last_cmp_response][:fex_get_last_cmp_result] rescue {}
      end
    end
  end
end
