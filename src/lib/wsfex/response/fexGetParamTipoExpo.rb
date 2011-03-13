#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::FEXGetParamTipoExpo < Response::FEXGetParam
    def format_record(record)
      "%02d%-250s%-8s%-8s" % [ record[:tex_id],
                               record[:tex_ds],
                               record[:tex_vig_desde],
                               record[:tex_vig_hasta] ]
    end

    def records
      @records ||= result[:fex_result_get][:cls_fex_response_tex] rescue []
    end

    def result
      @result ||= response[:fex_get_param_tipo_expo_response][:fex_get_param_tipo_expo_result] rescue []
    end
  end
end
