#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'wsferb/wsfe/client'
require "wsferb/wsfe/response/feCompTotXRequest"
#Dir[File.join(File.dirname(__FILE__), "response", "*.rb")].each { |file| require file }
require 'wsferb/wsfe/runner'
require "wsferb/version"

module WSFErb
  module WSFE
    include Version

  SERVICES = %w(FEAutRequest
                FEUltNroRequest
                FERecuperaQTYRequest
                FERecuperaLastCMPRequest
                FEConsultaCAERequest
                FEDummy)

    def self.run(options)
      begin
        r = case options.service.downcase
            when "fedummy"
              fe_dummy(options)
            when "fecomptotxrequest"
              fe_comp_tot_x_request(options)
            end
      rescue RuntimeError => e
        puts e.message
      end
      if options.out 
        File.open(options.out, 'w') { |f| f.puts(r) } 
      else
        puts r
      end
    end

    def self.fe_dummy(options)
      Client.fe_dummy
    end

    def self.fe_comp_tot_x_request(options)
      raise(ArgumentError, "CUIT missing") unless options.cuit
      Client.fe_comp_tot_x_request(self.ticket(options))
      Client.fe
    end

    def self.ticket(options)
      cert_file = options.cert
      key_file = options.key
      ticket = Ticket.load(options.cuit, options.ticket) if options.ticket
      ticket = WSAA::Client.requestTicket(options.cuit, 'wsfe', cert_file, key_file) if ticket.nil? || ticket.invalid?
      ticket.save(options.ticket) if ticket && ticket.valid? && options.ticket
      ticket
    end
  end
end
