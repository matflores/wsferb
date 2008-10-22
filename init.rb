#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008 Matiás Alejandro Flores <mflores@atlanware.com>
#
$: << File.expand_path(File.dirname(__FILE__) + "/lib")

require 'wsfe'
require 'silence'

silence_warnings do
  WSFE::Runner::Wsfe.run(ARGV)
end

exit 0
