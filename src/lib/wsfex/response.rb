#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response < AFIP::Response
    def parse_result(result, response_key, result_key, container)
      container ||= :fEXResultGet
      value_container = result.has_key?(container) ? result[container] : result
      value = value_container.has_key?(response_key) ? value_container[:response_key] : value_container
      value = value.has_key?(:value) ? value[:value].to_s : value.to_s
      errCode = result[:fex_err][:err_code].to_i
      errMsg = result[:fex_err][:err_msg]
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
