#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "savon"
require "wsferb/core_ext"

silence_warnings do
  Savon::SOAP::DateTimeRegexp = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$/
end

Savon.log = false
HTTPI.log = false
