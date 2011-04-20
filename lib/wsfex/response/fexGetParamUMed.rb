#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::FEXGetParamUMed < Response::FEXGetParam
    def format_record(record)
      "%02d%-250s%-8s%-8s" % [ record[:umed_id],
                               record[:umed_ds],
                               record[:umed_vig_desde],
                               record[:umed_vig_hasta] ]
    end

    def records
      @records ||= result[:fex_result_get][:cls_fex_response_u_med] rescue []
    end

    def result
      @result ||= response[:fex_get_param_u_med_response][:fex_get_param_u_med_result] rescue []
    end
  end
end
