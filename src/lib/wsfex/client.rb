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
      response = logged_action(log_file) do |driver|
        driver.fEXGetLast_ID(ticket_to_arg(ticket))
      end
      return WSFEX::Response.new(response, :fEXGetLast_IDResult, :id)
    end
      
    def self.logged_action(log_file=nil)
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      r = yield driver
      write_log
      r
    end

    def self.getLastIdOld(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      r = driver.fEXGetLast_ID(ticket_to_arg(ticket))
      write_log
      return WSFEX::Response.new(r, :fEXGetLast_IDResult, :id)
    end

    def self.getParamDstPais(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      r = driver.fEXGetPARAM_DST_pais(ticket_to_arg(ticket))
      write_log
      return WSFEX::Response.new(r, :fEXGetPARAM_DST_paisResult, :id)
    end

    def self.test(log_file=nil)
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      r = driver.fEXDummy(nil)
      write_log
      "authserver=#{r.fEXDummyResult.authServer}; appserver=#{r.fEXDummyResult.appServer}; dbserver=#{r.fEXDummyResult.dbServer};"
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

    def self.ticket_missing
      WSFEX::Response.new(nil, :nil, nil)
    end

    def self.ticket_to_arg(ticket)
      return { :Auth => { :Token => ticket.token, :Sign => ticket.sign, :Cuit => ticket.cuit } }
    end
  end

end
