#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamTipoExpo < WSFErb::Response
      def format_record(record)
        "1%03d%-8s%-8s%-250s" % [ record[:tex_id],
                                  record[:tex_vig_desde],
                                  record[:tex_vig_hasta],
                                  record[:tex_ds] ]
      end

      def records
        @records ||= result[:fex_result_get][:cls_fex_response_tex] rescue []
      end

      def result
        @result ||= response[:fex_get_param_tipo_expo_response][:fex_get_param_tipo_expo_result] rescue []
      end
    end
  end
end
