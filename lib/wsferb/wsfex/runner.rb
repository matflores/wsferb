#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
  end
end

require "wsfex/runner/base"

Dir[File.join(File.dirname(__FILE__), "runner", "*.rb")].each { |file| require file }
