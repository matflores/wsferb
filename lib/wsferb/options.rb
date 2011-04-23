#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "optparse"

module WSFErb
  class Options
    OPTIONS = {
      :cuit      => ["-c", "--cuit CUIT",    "Cuit del contribuyente."],
      :ticket    => ["-t", "--ticket TICKET","Ubicacion del ticket de acceso. Si existe y",
                                             "el ticket aun es valido, se utilizara para",
                                             "la comunicacion con el WSFE. En caso contrario",
                                             "se solicitara un nuevo ticket y se almacenara",
                                             "en la ubicacion especificada.",
                                             "Valor por defecto: ./<cuit>.xml"],
      :cert      => ["-r", "--cert CERT",    "Ubicacion del certificado digital provisto por AFIP.",
                                             "Valor por defecto: ./<cuit>.crt"],
      :key       => ["-k", "--key KEY",      "Ubicacion de la clave privada que se utilizara para",
                                             "firmar las solicitudes.",
                                             "Valor por defecto: ./<cuit>.key"],
      :out       => ["-o", "--out PATH",     "Guarda la respuesta en el archivo indicado (opcional)"],
      :log       => ["-l", "--log PATH",     "Guarda un log de la transaccion en el archivo indicado,",
                                             "incluyendo el xml devuelto por AFIP (opcional)."],
      :test      => ["-e", "--test",         "Ejecuta el servicio en el entorno de pruebas de AFIP."],
      :help      => ["-h", "--help",         "Muestra informacion de ayuda acerca del servicio especificado."],
      :version   => ["-v", "--version",      "Informa la version actual del script."]
    }

    attr_accessor :parser, :cuit, :ticket, :cert, :key, :out, :log, :help, :test, :version

    def self.parse(args=[])
      new(args)
    end

    def initialize(args=[])
      OptionParser.new { |p| @parser = p ; parse_options }

      begin
        parser.parse!(args)
      rescue OptionParser::InvalidOption => e
        info_exit
      end
    end

    def parse_options
      parser.on(*OPTIONS[:cuit])         { |cuit|   self.cuit = cuit unless cuit.empty? }
      parser.on(*OPTIONS[:cert])         { |cert|   self.cert = cert unless cert.empty? }
      parser.on(*OPTIONS[:key])          { |key|    self.key  = key  unless key.empty?  }
      parser.on(*OPTIONS[:out])          { |out|    self.out  = out  unless out.empty?  }
      parser.on(*OPTIONS[:log])          { |log|    self.log  = log  unless log.empty? ; Savon.log, Savon.logger = true, Logger.new(log) }
      parser.on(*OPTIONS[:ticket])       { |ticket| self.ticket = ticket unless ticket.empty? }

      parser.on_tail(*OPTIONS[:help])    { self.help    = true }
      parser.on_tail(*OPTIONS[:test])    { self.test    = true }
      parser.on_tail(*OPTIONS[:version]) { self.version = true }
    end

    def cuit=(cuit)
      @cuit = cuit
      @cert ||= "./#{@cuit}.crt"
      @key  ||= "./#{@cuit}.key"
      @log  ||= "./#{@cuit}.log"
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
