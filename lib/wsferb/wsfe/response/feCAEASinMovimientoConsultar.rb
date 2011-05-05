#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FECAEASinMovimientoConsultar < Response
      def format_record(record)
        "1%-14s%04d%-8s" % [ record[:caea],
                             record[:pto_vta],
                             record[:fch_proceso] ]
      end

      def records
        @records ||= result[:result_get][:fecaea_sin_mov] rescue []
      end

      def result
        response[:fecaea_sin_movimiento_consultar_response][:fecaea_sin_movimiento_consultar_result] rescue {}
      end
    end
  end
end
