#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FECAEAConsultar < Response
      def format_record(record)
        "1%06d%1d%-14s%-8s%-8s%-8s%-8s" % [ record[:periodo],
                                            record[:orden],
                                            record[:caea],
                                            record[:fch_vig_desde],
                                            record[:fch_vig_hasta],
                                            record[:fch_tope_inf],
                                            record[:fch_proceso] ]
      end

      def records
        @records ||= [ result[:result_get] ]
      end

      def result
        response[:fecaea_consultar_response][:fecaea_consultar_result] rescue {}
      end
    end
  end
end
