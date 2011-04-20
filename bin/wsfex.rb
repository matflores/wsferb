#!/usr/bin/env ruby
#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "rubygems"
require "pathname"

LIB_DIR = File.expand_path(File.join(File.dirname(Pathname.new(__FILE__).realpath), "..", "src", "lib"))

$: << LIB_DIR

require "wsfex"
require "silence"

silence_warnings do
  WSFEX::Runner::Wsfex.run(ARGV)
end

exit 0
