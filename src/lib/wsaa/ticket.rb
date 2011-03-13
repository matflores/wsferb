#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'time'
require 'rexml/document'

module WSAA

  class Ticket
    attr_accessor :cuit, :token, :sign, :source, :destination, :generationTime, :expirationTime

    def initialize(fields={})
      @cuit = fields[:cuit] if fields[:cuit]
      @token = fields[:token].to_s if fields[:token]
      @sign = fields[:sign].to_s if fields[:sign]
      @source = fields[:source].to_s if fields[:source]
      @destination = fields[:destination].to_s if fields[:destination]
      @generationTime = fields[:generationTime] if fields[:generationTime]
      @expirationTime = fields[:expirationTime] if fields[:expirationTime]
    end

    def valid?
      @cuit && @token && @sign && @expirationTime && !expired?
    end

    def invalid?
      !valid?
    end

    def expired?
      @expirationTime && @expirationTime < Time.now
    end

    def to_xml
      "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" + 
      "<loginTicketResponse version=\"1\">\n" +
      "  <header>\n" +
      "    <source>#{source}</source>\n" +
      "    <destination>#{destination}</destination>\n" +
      "    <uniqueId>#{@generationTime.to_i}</uniqueId>\n" +
      "    <generationTime>#{@generationTime.iso8601}</generationTime>\n" +
      "    <expirationTime>#{@expirationTime.iso8601}</expirationTime>\n" +
      "  </header>\n" +
      "  <credentials>\n" +
      "    <token>#{token}</token>\n" +
      "    <sign>#{sign}</sign>\n" +
      "  </credentials>\n" +
      "</loginTicketResponse>\n"
    end

    def request_to_xml
      "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + 
      "<loginTicketRequest version=\"1.0\">\n" +
      "  <header>\n" +
      "    <uniqueId>#{@generationTime.to_i}</uniqueId>\n" +
      "    <generationTime>#{@generationTime.iso8601}</generationTime>\n" +
      "    <expirationTime>#{@expirationTime.iso8601}</expirationTime>\n" +
      "  </header>\n" +
      "  <service>wsfe</service>\n" +
      "</loginTicketRequest>\n"
    end

    def save(xml_file)
      f = File.new(xml_file, "w")
      f.write to_xml
      f.close
    end

    def self.from_xml(cuit, xml)
      data = REXML::Document.new(xml)
      token = data.get_text("//credentials/token")
      sign = data.get_text("//credentials/sign")
      source = data.get_text("//source")
      destination = data.get_text("//destination")
      generationTime = Time.parse(data.get_text("//generationTime").to_s)
      expirationTime = Time.parse(data.get_text("//expirationTime").to_s)
      ticket = new(:cuit => cuit,
                   :token => token, 
                   :sign => sign, 
                   :source => source,
                   :destination => destination,
                   :generationTime => generationTime, 
                   :expirationTime => expirationTime)
    end
    
    def self.load(cuit, xml_file)
      return nil unless File.exists?(xml_file)
      from_xml(cuit, File.read(xml_file))
    end

  end

end
