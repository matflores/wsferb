#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetParamPtoVenta < Response
      def format_record(record)
        "1%04d%1s%-8s" % [ record[:pve_nro],
                           record[:pve_bloqueado],
                           record[:pve_fch_baja] ]
      end

      def records
        @records ||= [result[:fex_result_get][:cls_fex_response_pto_venta]].flatten rescue []
      end

      def result
        @result ||= response[:fex_get_param_pto_venta_response][:fex_get_param_pto_venta_result] rescue []
      end
    end
  end
end
