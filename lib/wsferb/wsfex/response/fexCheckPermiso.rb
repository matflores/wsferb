# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXCheckPermiso < Response
      def format_record(record)
        "1%-2s" % [ record[:status] ]
      end

      def records
        [ result[:fex_result_get] ] rescue []
      end

      def result
        response[:fex_check_permiso_response][:fex_check_permiso_result] rescue {}
      end
    end
  end
end
