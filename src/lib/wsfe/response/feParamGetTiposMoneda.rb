#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  class Response::FEParamGetTiposMoneda < Response::FEParam
    def format_record(record)
      "%-3s%-250s%-8s%-8s" % [ record[:id],
                               record[:desc],
                               record[:fch_desde],
                               record[:fch_hasta] ]
    end

    def records
      @records ||= result[:result_get][:moneda] rescue []
    end

    def result
      @result ||= response[:fe_param_get_tipos_moneda_response][:fe_param_get_tipos_moneda_result] rescue []
    end
  end
end
