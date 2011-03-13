#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
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

require 'wsfex/response/fexAuthorize'
require 'wsfex/response/fexCheckPermiso'
require 'wsfex/response/fexGetCmp'
require 'wsfex/response/fexGetLastCmp'
require 'wsfex/response/fexGetLastId'
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
