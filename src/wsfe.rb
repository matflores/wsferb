#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
$: << File.expand_path(File.dirname(__FILE__) + "/lib")

require 'rubygems'
require 'wsfe'
require 'silence'

WSFE::Runner::Wsfe.run(ARGV)

exit 0
