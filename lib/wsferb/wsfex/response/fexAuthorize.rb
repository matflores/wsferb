# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXAuthorize < WSFErb::Response
      def value
        info[:cae] || "n/d" rescue "n/d"
      end

      def result
        response[:fex_authorize_response][:fex_authorize_result] rescue {}
      end

      def info
        result[:fex_result_auth] || {}
      end
    end
  end
end
