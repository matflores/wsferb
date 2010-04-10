#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response < AFIP::Response
    def parse_result(result, fieldname, container)
      container ||= :fEXResultGet
      value_container = result.respond_to?(container) ? result.send(container) : result
      value = value_container.respond_to?(fieldname) ? value_container.send(fieldname) : fieldname
      value = value.respond_to?(:value) ? value.value.to_s : value.to_s
      errCode = result.fEXErr.errCode.to_i
      errMsg = result.fEXErr.errMsg
      return value, errCode, errMsg
    end
  end
end

require 'wsfex/response/fexGetParam'
require 'wsfex/response/fexGetParamCtz'
require 'wsfex/response/fexGetParamDstCuit'
require 'wsfex/response/fexGetParamDstPais'
require 'wsfex/response/fexGetParamIncoterms'
require 'wsfex/response/fexGetParamIdiomas'
require 'wsfex/response/fexGetParamMon'
require 'wsfex/response/fexGetParamPtoVenta'
require 'wsfex/response/fexGetParamTipoCbte'
require 'wsfex/response/fexGetParamTipoExpo'
require 'wsfex/response/fexGetParamUMed'
