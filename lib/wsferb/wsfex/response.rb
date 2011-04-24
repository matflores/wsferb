#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "response"

module WSFEX
  class Response < ::Response
    attr_accessor :result

    def err_code
      @err_code ||= result[:fex_err][:err_code].to_i rescue "n/d"
    end

    def err_msg
      @err_msg ||= result[:fex_err][:err_msg] rescue "n/d"
    end
  end
end

require "wsfex/response/fexGetParam"

Dir[File.join(File.dirname(__FILE__), "response", "*.rb")].each { |file| require file }