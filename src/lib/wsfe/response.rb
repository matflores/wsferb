#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  class Response < AFIP::Response
    def parse_result(result, fieldname)
      value = result.respond_to?(fieldname) ? result.send(fieldname) : fieldname
      value = value.respond_to?(:value) ? value.value.to_i : value.to_i
      errCode = result.rError.percode.to_i
      errMsg = result.rError.perrmsg
      return value, errCode, errMsg
    end
  end
end
