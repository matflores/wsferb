#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'afip'
require 'wsfex/fex'
require 'wsfex/client'
require 'wsfex/response'
require 'wsfex/version'
require 'wsfex/runner'

module WSFEX
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
