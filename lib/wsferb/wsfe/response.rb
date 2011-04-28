#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/response"

module WSFErb
  module WSFE
    class Response < WSFErb::Response
      def err_code
        @err_code ||= result[:err][:err_code].to_i rescue "n/d"
      end

      def err_msg
        @err_msg ||= result[:err][:err_msg] rescue "n/d"
      end
    end
  end
end

Dir[File.join(File.dirname(__FILE__), "response", "*.rb")].each { |file| require file }
