#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamTipoCbte < Response::FEXGetParam
      def format_record(record)
        "%02d%-250s%-8s%-8s" % [ record[:cbte_id],
                                 record[:cbte_ds],
                                 record[:cbte_vig_desde],
                                 record[:cbte_vig_hasta] ]
      end

      def records
        @records ||= result[:fex_result_get][:cls_fex_response_tipo_cbte] rescue []
      end

      def result
        @result ||= response[:fex_get_param_tipo_cbte_response][:fex_get_param_tipo_cbte_result] rescue []
      end
    end
  end
end
