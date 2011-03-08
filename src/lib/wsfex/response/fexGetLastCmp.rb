# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::FEXGetLastCmp < Response
    def value
      result[:fex_result_last_cmp][:cbte_nro] rescue "n/d"
    end

    def result
      response[:fex_get_last_cmp_response][:fex_get_last_cmp_result] rescue {}
    end
  end
end
