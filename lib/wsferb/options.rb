# encoding: utf-8
#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "optparse"

module WSFErb
  class Options
    OPTIONS = {
      :cuit      => ["-c", "--cuit CUIT",    "Cuit del contribuyente."],
      :ticket    => ["-t", "--ticket TICKET","Ubicación del ticket de acceso. Si existe y",
                                             "el ticket aún es válido, se utilizará para",
                                             "la comunicación con el WSFE. En caso contrario",
                                             "se solicitará un nuevo ticket y se almacenará",
                                             "en la ubicación especificada."],
      :cert      => ["-r", "--cert CERT",    "Ubicación del certificado digital provisto por AFIP.",
                                             "Valor por defecto: ./<cuit>.crt"],
      :key       => ["-k", "--key KEY",      "Ubicación de la clave privada que se utilizará para",
                                             "firmar las solicitudes.",
                                             "Valor por defecto: ./<cuit>.key"],
      :out       => ["-o", "--out PATH",     "Guarda la respuesta en el archivo indicado (opcional)"],
      :log       => ["-l", "--log PATH",     "Guarda un log de la transacción en el archivo indicado,",
                                             "incluyendo el xml devuelto por AFIP."],
      :test      => ["-e", "--test",         "Ejecuta el servicio en el entorno de pruebas de AFIP."],
      :help      => ["-h", "--help",         "Muestra información de ayuda acerca del servicio especificado."],
      :version   => ["-v", "--version",      "Informa la versión actual del WSFErb."]
    }

    attr_accessor :parser, :service, :arguments, :cuit, :ticket, :cert, :key, :out, :log, :help, :test, :version

    def self.parse(options=[])
      case options
      when Array
        new(options)
      when Options
        options
      else
        nil
      end
    end

    def initialize(args=[])
      OptionParser.new { |p| @parser = p ; parse_options }

      begin
        parser.parse!(args)
        @service = args.shift
        @arguments = args.dup
      rescue OptionParser::InvalidOption => e
        info_exit
      end
    end

    def parse_options
      parser.summary_width = 20

      parser.on(*OPTIONS[:cuit])         { |cuit|   self.cuit   = cuit unless cuit.empty? }

      parser.on(*OPTIONS[:cert])         { |cert|   self.cert   = File.expand_path(cert)   unless cert.empty?   }
      parser.on(*OPTIONS[:key])          { |key|    self.key    = File.expand_path(key)    unless key.empty?    }
      parser.on(*OPTIONS[:out])          { |out|    self.out    = File.expand_path(out)    unless out.empty?    }
      parser.on(*OPTIONS[:log])          { |log|    self.log    = File.expand_path(log)    unless log.empty?    }
      parser.on(*OPTIONS[:ticket])       { |ticket| self.ticket = File.expand_path(ticket) unless ticket.empty? }

      parser.on_tail(*OPTIONS[:help])    { self.help    = true }
      parser.on_tail(*OPTIONS[:test])    { self.test    = true }
      parser.on_tail(*OPTIONS[:version]) { self.version = true }
    end

    def cuit=(cuit)
      @cuit = cuit
      @cert ||= File.expand_path("./#{@cuit}.crt")
      @key  ||= File.expand_path("./#{@cuit}.key")
    end

    def help?
      !!@help
    end

    def test?
      !!@test
    end

    def version?
      !!@version
    end
  end
end
