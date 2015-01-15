#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/config"
require "wsferb/core_ext"
require "wsferb/dependencies"
require "wsferb/errors"
require "wsferb/options"
require "wsferb/ticket"
require "wsferb/version"
require "wsferb/wsaa"
require "wsferb/wsfe"
require "wsferb/wsfex"

module WSFErb
  @@test_mode_enabled = false

  def self.enable_test_mode
    @@test_mode_enabled = true
  end

  def self.disable_test_mode
    @@test_mode_enabled = false
  end

  def self.test_mode_enabled?
    @@test_mode_enabled
  end

  def self.client(options)
    Savon::Client.new do |wsdl, http|
      http.auth.ssl.verify_mode = :none
      wsdl.document = options[:wsdl]
      wsdl.endpoint = test_mode_enabled? ? options[:testing_url] : options[:production_url]
    end
  end
end
