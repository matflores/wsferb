#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamCtz < Response
      def format_record(record)
        "1%012d%-8s" % [ (record[:mon_ctz].to_f * 1000000).to_i,
                          record[:mon_fecha] ]
      end

      def records
        [ result[:fex_result_get] ] rescue []
      end

      def result
        @result ||= response[:fex_get_param_ctz_response][:fex_get_param_ctz_result] rescue {}
      end
    end
  end
end
