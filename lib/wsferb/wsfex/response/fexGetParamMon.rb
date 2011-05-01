#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamMon < Response
      def format_record(record)
        "1%-3s%-8s%-8s%-250s" % [ record[:mon_id],
                                  record[:mon_vig_desde],
                                  record[:mon_vig_hasta],
                                  record[:mon_ds] ]
      end

      def records
        @records ||= [result[:fex_result_get][:cls_fex_response_mon]].flatten rescue []
      end

      def result
        @result ||= response[:fex_get_param_mon_response][:fex_get_param_mon_result] rescue []
      end
    end
  end
end
