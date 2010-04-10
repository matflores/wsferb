#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamDstPais < Response
    def parse_result(result, fieldname)
      container = result.respond_to?(:fEXResultGet) ? result.send(:fEXResultGet) : result
      value = container.respond_to?(fieldname) ? container.send(fieldname) : fieldname
      value = value.respond_to?(:value) ? value.value.to_i : value.to_i
      errCode = result.fEXErr.errCode.to_i
      errMsg = result.fEXErr.errMsg
      return value, errCode, errMsg
    end

    def to_s
      return super unless success?

      "Paises ok"
    end
  end
end
