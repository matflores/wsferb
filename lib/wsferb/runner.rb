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
                   raise(InvalidDir, File.dirname(options.out)) if options.out && !File.exists?(File.dirname(options.out))
                   raise(InvalidDir, File.dirname(options.log)) if options.log && !File.exists?(File.dirname(options.log))

                   if options.log
                     Savon.log, Savon.logger = true, Logger.new(options.log)
                   end

                   run_service
                 rescue WSFErb::UsageException => usage
                   usage.to_s
                 rescue WSFErb::Error => error
                   error.to_s
                 rescue StandardError => error
                   WSFErb::GenericError.new(error.to_s)
                 end

      if options.out && File.exists?(File.dirname(options.out))
        File.open(options.out, "w") { |f| f.puts(response) }
      else
        puts(response)
      end
    end

    def service
      @service ||= options.service
    end

    def ticket
      raise(CertificateNotFound, options.cert) unless File.exists?(options.cert)
      raise(PrivateKeyNotFound, options.key) unless File.exists?(options.key)

      ticket = Ticket.load(options.cuit, options.ticket) if options.ticket
      ticket = WSAA::Client.requestTicket(options.cuit, script, options.cert, options.key) if ticket.nil? || ticket.invalid?
      ticket.save(options.ticket) if ticket && ticket.valid? && options.ticket
      ticket
    end

    def usage(syntax)
      options.parser.banner = "Modo de uso: #{script} #{syntax} [opciones]"
      raise(UsageException, options.parser)
    end
  end
end
