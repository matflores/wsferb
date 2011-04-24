#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/response"

module WSFErb
  module WSFE
    class Response < ::Response
      attr_accessor :result

      def err_code
        @err_code ||= result[:fex_err][:err_code].to_i rescue "n/d"
      end

      def err_msg
        @err_msg ||= result[:fex_err][:err_msg] rescue "n/d"
      end

      def formatted_records
        []
      end

      def formatted_errors
        []
      end

      def to_s
        (formatted_records + formatted_errors).join "\n"
      end
    end
  end
end

require "wsferb/wsfe/response/feParam"

Dir[File.join(File.dirname(__FILE__), "response", "*.rb")].each { |file| require file }
