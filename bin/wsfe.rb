#!/usr/bin/env ruby
#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "rubygems"
require "pathname"

$: << File.expand_path(File.join(File.dirname(Pathname.new(__FILE__).realpath), "..", "lib"))

require "wsferb"

options = WSFErb::Options.parse(ARGV)

if options.test?
  WSFErb::WSFE::Client.enable_test_mode
  WSFErb::WSAA::Client.enable_test_mode
end

WSFErb::WSFE.run(options)

exit 0
