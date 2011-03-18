#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  class Response::FEParamGetTiposOpcional < Response::FEParam
    def format_record(record)
      "%04d%-250s%-8s%-8s" % [ record[:id],
                               record[:desc],
                               record[:fch_desde],
                               record[:fch_hasta] ]
    end

    def records
      @records ||= result[:result_get][:opcional_tipo] rescue []
    end

    def result
      @result ||= response[:fe_param_get_tipos_opcional_response][:fe_param_get_tipos_opcional_result] rescue []
    end
  end
end
