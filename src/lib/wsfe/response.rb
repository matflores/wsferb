#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  class Response < AFIP::Response
    attr_accessor :result

    def err_code
      @err_code ||= result[:fex_err][:err_code].to_i rescue "n/d"
    end

    def err_msg
      @err_msg ||= result[:fex_err][:err_msg] rescue "n/d"
    end
  end
end

require "wsfe/response/feCompUltimoAutorizado"
require "wsfe/response/feCompTotXRequest"
