#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "time"
require "openssl"
require "savon"
require "config"

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
        response = client.request(:ns1, :login_cms) do
          soap.body = { :in0 => signed }
        end
        ticket = WSAA::Ticket.from_xml(cuit, response.to_hash[:login_cms_response][:login_cms_return])
      rescue Exception => e
        puts e.message
        puts e.backtrace.join("\n")
        ticket = nil
      end
      ticket
    end

    def self.client
      @client ||= Savon::Client.new do |wsdl, http|
        wsdl.document = WSDL
        wsdl.endpoint = test_mode_enabled ? TEST_URL : PROD_URL
      end
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
      # separar lineas
      lines = signed.to_s.split("\n")
      # eliminar primera y ultima linea
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
