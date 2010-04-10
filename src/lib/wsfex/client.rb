#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'time'
require 'soap/wsdlDriver'
require 'wsaa'

module WSFEX

  class Client < AFIP::Client

    WSDL = File.dirname(__FILE__) + '/wsfex.wsdl'
    PROD_URL = 'https://servicios1.afip.gov.ar/wsfex/service.asmx'
    TEST_URL = 'https://wswhomo.afip.gov.ar/wsfex/service.asmx'

    def self.getLastId(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetLast_ID(ticket_to_arg(ticket))
      end
      return WSFEX::Response.new(response, :fEXGetLast_IDResult, :fEXResultGet, :id)
    end
      
    def self.getParamDstPais(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_DST_pais(ticket_to_arg(ticket))
      end
      return WSFEX::Response.new(response, :fEXGetPARAM_DST_paisResult, :nil, :nil)
    end

    def self.test(log_file=nil)
      response = with_driver(:log => log_file) do |driver|
        driver.fEXDummy(nil)
      end
      "authserver=#{response.fEXDummyResult.authServer}; appserver=#{response.fEXDummyResult.appServer}; dbserver=#{response.fEXDummyResult.dbServer};"
    end

    def self.ticket_missing
      WSFEX::Response.new(nil, :nil, nil)
    end

    def self.ticket_to_arg(ticket)
      return { :Auth => { :Token => ticket.token, :Sign => ticket.sign, :Cuit => ticket.cuit } }
    end
  end

end
