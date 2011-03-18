# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  class Response::FECompTotXRequest < Response
    def value
      result[:reg_x_req] rescue "n/d"
    end

    def result
      response[:fe_comp_tot_x_request_response][:fe_comp_tot_x_request_result] rescue {}
    end
  end
end
