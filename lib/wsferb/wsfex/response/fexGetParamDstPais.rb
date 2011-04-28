#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamDstPais < WSFErb::Response
      def format_record(record)
        "1%-3s%-250s" % [ record[:dst_codigo], record[:dst_ds] ]
      end

      def records
        @records ||= result[:fex_result_get][:cls_fex_response_dst_pais] rescue []
      end

      def result
        @result ||= response[:fex_get_param_dst_pais_response][:fex_get_param_dst_pais_result] rescue []
      end
    end
  end
end
