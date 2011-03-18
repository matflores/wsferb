# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  class Response::FECompUltimoAutorizado < Response
    def value
      result[:cbte_nro] rescue "n/d"
    end

    def result
      response[:fe_comp_ultimo_autorizado_response][:fe_comp_ultimo_autorizado_result] rescue {}
    end
  end
end
