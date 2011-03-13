# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::FEXGetCmp < Response
    def value
      info[:cae] || "n/d" rescue "n/d"
    end

    def result
      response[:fex_get_cmp_response][:fex_get_cmp_result] rescue {}
    end

    def info
      result[:fex_result_get] || {}
    end
  end
end
