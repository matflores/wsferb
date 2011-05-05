# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FECAEASinMovimientoInformar < Response
      def format_record(record)
        "1%-14s%04d%1s%-8s" % [ record[:caea],
                                record[:pto_vta],
                                record[:resultado],
                                record[:fch_proceso] ]
      end

      def records
        @records ||= [ result ]
      end

      def result
        response[:fecaea_sin_movimiento_response][:fecaea_sin_movimiento_result] rescue {}
      end
    end
  end
end
