#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamUMed < Response
      def format_record(record)
        "1%03d%-8s%-8s%-250s" % [ record[:umed_id]        || 0,
                                  record[:umed_vig_desde] || '',
                                  record[:umed_vig_hasta] || '',
                                  record[:umed_ds]        || '']
      end

      def records
        @records ||= [result[:fex_result_get][:cls_fex_response_u_med]].flatten rescue []
      end

      def result
        @result ||= response[:fex_get_param_u_med_response][:fex_get_param_u_med_result] rescue []
      end
    end
  end
end
