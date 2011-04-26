#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/version"
require "wsferb/wsfex/fex"
require "wsferb/wsfex/client"
require "wsferb/wsfex/response"

module WSFErb
  module WSFEX
    include Version

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
end
