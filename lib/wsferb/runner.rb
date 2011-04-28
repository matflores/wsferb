#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/options"

module WSFErb
  class Runner
    attr_accessor :options

    def initialize(options)
      @options = options
    end

    def run
      response = begin
                   run_service
                 rescue StandardError => e
                   e.message
                 end

      if options.out
        File.open(options.out, "w") { |f| f.puts(response) }
      else
        puts(response)
      end
    end

    def service
      @service ||= options.service
    end

    def ticket
      cert_file = options.cert
      key_file = options.key
      ticket = Ticket.load(options.cuit, options.ticket) if options.ticket
      ticket = WSAA::Client.requestTicket(options.cuit, script, cert_file, key_file) if ticket.nil? || ticket.invalid?
      ticket.save(options.ticket) if ticket && ticket.valid? && options.ticket
      ticket
    end

    def usage(syntax)
      options.parser.banner = "Modo de uso: #{script} #{syntax} [opciones]"
      raise(ArgumentError, options.parser)
    end
  end
end
