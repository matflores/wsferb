#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/response"

module WSFErb
  module WSFE
    class Response < WSFErb::Response
      def errors
        [(result[:errors][:err] rescue [])].flatten.compact.map { |err| { :code => (err[:code].to_i rescue "n/d"), :message => (err[:msg] rescue "n/d") } }
      end

      def err_code
        @err_code ||= result[:errors][:err][:code].to_i rescue "n/d"
      end

      def err_msg
        @err_msg ||= result[:errors][:err][:msg] rescue "n/d"
      end
    end
  end
end

Dir[File.join(File.dirname(__FILE__), "response", "*.rb")].each { |file| require file }
