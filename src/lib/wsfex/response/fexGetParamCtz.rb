#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::FEXGetParamCtz < Response::FEXGetParam
    def format_record(record)
      "%-3s%-250s" % [ record[:dst_codigo], record[:dst_ds] ]
    end

    def records(result)
      @records ||= result[:fex_result_get][:cls_fex_response_ctz] rescue []
    end

    def result
      @result ||= response[:fex_get_param_ctz_response][:fex_get_param_ctz_result] rescue {}
    end
  end
end
