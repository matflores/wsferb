#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FEParamGetPtosVenta < Response::FEParam
      def format_record(record)
        "%04d%-8s%1s%-8s" % [ record[:nro],
                              record[:emision_tipo],
                              record[:bloqueado],
                              record[:fch_baja] ]
      end

      def records
        @records ||= result[:result_get][:pto_venta] rescue []
      end

      def result
        @result ||= response[:fe_param_get_ptos_venta_response][:fe_param_get_ptos_venta_result] rescue []
      end
    end
  end
end
