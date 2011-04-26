#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamMon < Response::FEXGetParam
      def format_record(record)
        "%-3s%-250s%-8s%-8s" % [ record[:mon_id],
                                 record[:mon_ds],
                                 record[:mon_vig_desde],
                                 record[:mon_vig_hasta] ]
      end

      def records
        @records ||= result[:fex_result_get][:cls_fex_response_mon] rescue []
      end

      def result
        @result ||= response[:fex_get_param_mon_response][:fex_get_param_mon_result] rescue []
      end
    end
  end
end
