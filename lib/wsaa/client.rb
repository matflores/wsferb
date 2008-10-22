require 'time'
require 'openssl'
require 'soap/wsdlDriver'
require 'afip'

module WSAA

  class Client < AFIP::Client

    include OpenSSL

    WSDL = File.dirname(__FILE__) + '/wsaa.wsdl'
    PROD_URL = 'https://wsaa.afip.gov.ar/ws/services/LoginCms'
    TEST_URL = 'https://wsaahomo.afip.gov.ar/ws/services/LoginCms'

    def self.requestTicket(cuit, service, cert_file, key_file)
      request = generate_request_for(service)
      signed = sign_request(request, cert_file, key_file)
      begin
        driver = SOAP::WSDLDriverFactory.new(WSDL).create_rpc_driver
        driver.endpoint_url = test_mode_enabled? ? self::TEST_URL : self::PROD_URL
        driver.options['protocol.http.ssl_config.verify_mode'] = OpenSSL::SSL::VERIFY_NONE if ssl_enabled?
        r = driver.loginCms(:in0 => signed)
        ticket = WSAA::Ticket.from_xml(cuit, r.loginCmsReturn) 
      rescue
        ticket = nil
      end
      ticket
    end

  private

    def self.generate_request_for(service)
      t = Time.now
      generationTime = t - 4200
      expirationTime = t + 4200

      xml = []
      xml << '<?xml version="1.0" encoding="UTF-8"?>'
      xml << '<loginTicketRequest version="1.0">'
      xml << "  <header>"
      xml << "    <uniqueId>#{t.to_i}</uniqueId>"
      xml << "    <generationTime>#{generationTime.iso8601}</generationTime>"
      xml << "    <expirationTime>#{expirationTime.iso8601}</expirationTime>"
      xml << "  </header>"
      xml << "  <service>#{service}</service>"
      xml << "</loginTicketRequest>\n"

      xml.join "\n"
    end

    def self.sign_request(request, cert_file, key_file)
      signed = PKCS7::sign(load_cert(cert_file), load_key(key_file), request, [], 0)
      # separar lìneas
      lines = signed.to_s.split("\n")
      # eliminar primera y ùltima lìnea
      lines.shift
      lines.pop
      # y volver a juntarlas
      lines.join("\n")
    end

    def self.load_cert(cert_file)
      X509::Certificate.new(File.read(cert_file))
    end

    def self.load_key(key_file)
      PKey::RSA.new(File.read(key_file))
    end

  end

end
