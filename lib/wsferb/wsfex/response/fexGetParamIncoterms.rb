#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamIncoterms < WSFErb::Response
      def format_record(record)
        "1%-3s%-8s%-8s%-250s" % [ record[:inc_id],
                                  record[:inc_vig_desde],
                                  record[:inc_vig_hasta],
                                  record[:inc_ds] ]
      end

      def records
        @records ||= result[:fex_result_get][:cls_fex_response_inc] rescue []
      end

      def result
        @result ||= response[:fex_get_param_incoterms_response][:fex_get_param_incoterms_result] rescue []
      end
    end
  end
end
