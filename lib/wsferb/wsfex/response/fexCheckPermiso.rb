# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXCheckPermiso < Response
      def value
        result[:fex_result_get][:status] rescue "n/d"
      end

      def result
        response[:fex_check_permiso_response][:fex_check_permiso_result] rescue {}
      end
    end
  end
end
