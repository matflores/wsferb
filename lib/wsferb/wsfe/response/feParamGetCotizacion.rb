#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FEParamGetCotizacion < Response
      def format_record(record)
        "1%-3s%012d%-8s" % [ record[:mon_id],
                             (record[:mon_cotiz].to_f * 1000000).to_i,
                             record[:fch_cotiz] ]
      end

      def records
        @records ||= [ result[:result_get] ]
      end

      def result
        response[:fe_param_get_cotizacion_response][:fe_param_get_cotizacion_result] rescue {}
      end
    end
  end
end
