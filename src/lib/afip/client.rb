#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'soap/wsdlDriver'

module AFIP

  class Client

    WSDL = ''
    PROD_URL = ''
    TEST_URL = ''

    @@ssl_enabled = false
    @@test_mode_enabled = false

    def self.enable_ssl
      @@ssl_enabled = true
    end

    def self.disable_ssl
      @@ssl_enabled = false
    end

    def self.ssl_enabled?
      @@ssl_enabled
    end

    def self.enable_test_mode
      @@test_mode_enabled = true
    end

    def self.disable_test_mode
      @@test_mode_enabled = false
    end

    def self.test_mode_enabled?
      @@test_mode_enabled
    end

  private

    def self.create_rpc_driver
      begin
        driver = SOAP::WSDLDriverFactory.new(self::WSDL).create_rpc_driver
        driver.endpoint_url = test_mode_enabled? ? self::TEST_URL : self::PROD_URL
        driver.options['protocol.http.ssl_config.verify_mode'] = OpenSSL::SSL::VERIFY_NONE if ssl_enabled?
      rescue
        driver = nil
      end
      driver
    end

  end

end
