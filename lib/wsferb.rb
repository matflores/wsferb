#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/config"
require "wsferb/core_ext"
require "wsferb/options"
require "wsferb/ticket"
require "wsferb/version"
require "wsferb/wsaa"
require "wsferb/wsfe"
require "wsferb/wsfex"

module WSFErb
  def self.enable_test_mode
    WSAA::Client.enable_test_mode
    WSFE::Client.enable_test_mode
    WSFEX::Client.enable_test_mode
  end
end
