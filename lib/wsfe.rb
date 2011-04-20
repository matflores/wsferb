#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'afip'
require 'wsfe/client'
require 'wsfe/response'
require 'wsfe/runner'
require "version"

module WSFE
  include VERSION

  SERVICES = %w(FEAutRequest
                FEUltNroRequest
                FERecuperaQTYRequest
                FERecuperaLastCMPRequest
                FEConsultaCAERequest
                FEDummy)
end
