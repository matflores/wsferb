#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::FEXGetParamDstCuit < Response::FEXGetParam
    def format_record(record)
      "%-11s%-250s" % [ record[:dst_cuit], record[:dst_ds] ]
    end

    def records
      @records ||= result[:fex_result_get][:cls_fex_response_dst_cuit] rescue []
    end

    def result
      @result ||= response[:fex_get_param_dst_cuit_response][:fex_get_param_dst_cuit_result] rescue []
    end
  end
end
