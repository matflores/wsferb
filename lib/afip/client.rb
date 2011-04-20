#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#

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

  protected

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

    def self.with_driver(options={})
      log_file = options[:log]
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      response = yield driver
      write_log
      response
    end

    def self.prepare_log(log_file, driver)
      @@log_file = log_file
      @@wiredump = ''
      if @@log_file
        driver.wiredump_dev = @@wiredump
      end
    end

    def self.write_log
      if @@log_file
        File.open(@@log_file, 'w') { |f| f.write @@wiredump }
      end
    end

  end

end
