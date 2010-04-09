#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'afip'
require 'wsfe/client'
require 'wsfe/response'
require 'wsfe/version'
require 'wsfe/runner'

module WSFE
  SERVICES = %w(FEAutRequest FEUltNroRequest FERecuperaQTYRequest FERecuperaLastCMPRequest FEConsultaCAERequest FEDummy)
end
