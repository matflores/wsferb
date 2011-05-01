#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamIdiomas < Response
      def format_record(record)
        "1%03d%-8s%-8s%-250s" % [ record[:idi_id],
                                  record[:idi_vig_desde],
                                  record[:idi_vig_hasta],
                                  record[:idi_ds] ]
      end

      def records
        @records ||= [result[:fex_result_get][:cls_fex_response_idi]].flatten rescue []
      end

      def result
        @result ||= response[:fex_get_param_idiomas_response][:fex_get_param_idiomas_result] rescue {}
      end
    end
  end
end
