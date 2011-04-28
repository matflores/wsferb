# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetLastId < WSFErb::Response
      def format_record(record)
        "1%015d" % [ record[:id] ]
      end

      def records
        [ result[:fex_result_get] ] rescue []
      end

      def result
        response[:fex_get_last_id_response][:fex_get_last_id_result] rescue {}
      end
    end
  end
end
