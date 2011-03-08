#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::FEXGetParamPtoVenta < Response::FEXGetParam
    def format_record(record)
      "%04d%1s%-8s" % [ record[:pve_nro],
                        record[:pve_bloqueado],
                        record[:pve_fch_baja] ]
    end

    def records
      @records ||= result[:fex_result_get][:cls_fex_response_pto_venta] rescue []
    end

    def result
      @result ||= response[:fex_get_param_pto_venta_response][:fex_get_param_pto_venta_result] rescue []
    end
  end
end
