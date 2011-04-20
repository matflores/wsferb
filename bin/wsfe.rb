#!/usr/bin/env ruby
#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "rubygems"
require "pathname"

LIB_DIR = File.expand_path(File.join(File.dirname(Pathname.new(__FILE__).realpath), "..", "lib"))

$: << LIB_DIR

require "wsfe"
require "silence"

silence_warnings do
  WSFE::Runner::Wsfe.run(ARGV)
end

exit 0
