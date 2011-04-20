#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'afip'
require 'core_ext/hash'
require 'wsfex/fex'
require 'wsfex/client'
require 'wsfex/response'
require 'wsfex/runner'
require "version"

module WSFEX
  include VERSION

  SERVICES = %w(FEXDummy
                FEXAuthorize
                FEXGetCmp
                FEXGetLastId
                FEXGetLastCmp
                FEXGetParamMon
                FEXGetParamTipoCbte
                FEXGetParamTipoExpo
                FEXGetParamUMed
                FEXGetParamIdiomas
                FEXGetParamDstPais
                FEXGetParamDstCuit
                FEXGetParamIncoterms
                FEXGetParamCtz
                FEXGetParamPtoVenta
                FEXCheckPermiso)
end
