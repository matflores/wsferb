require 'optparse'
require File.dirname(__FILE__) + '/options.rb'
require File.dirname(__FILE__) + '/../version.rb'

module WSFE
  class OptionParser < ::OptionParser
    class << self
      def parse(args, err, out)
        parser = new(err, out)
        parser.parse(args)
        parser.options
      end
    end

    attr_reader :options

    COMMON_OPTIONS = {
        :out       => ["-o", "--out PATH",     "Guarda la respuesta en el archivo indicado (opcional)"],
        :test      => ["-e", "--test",         "Ejecuta el servicio en el entorno de pruebas de AFIP."],
        :info      => ["-i", "--info",         "Muestra información de ayuda acerca para el servicio especificado."],
        :version   => ["-v", "--version",      "Informa la versión actual del script."]
    }
    AUTHENTICATION_OPTIONS = {
        :cuit      => ["-c", "--cuit CUIT",    "Cuit del contribuyente."],
        :ticket    => ["-t", "--ticket TICKET","Ubicación del ticket de acceso. Si existe y",
                                               "el ticket aún es válido, se utilizará para",
                                               "la comunicación con el WSFE. En caso contrario",
                                               "se solicitará un nuevo ticket y se almacenará",
                                               "en la ubicación especificada.",
                                               "Valor por defecto: ./<cuit>.xml"],
        :cert      => ["-r", "--cert CERT",    "Ubicación del certificado digital provisto por AFIP.",
                                               "Valor por defecto: ./<cuit>.crt"],
        :key       => ["-k", "--key KEY",      "Ubicación de la clave privada que se utilizará para",
                                               "firmar las solicitudes.",
                                               "Valor por defecto: ./<cuit>.key"]
    }
    AUT_OPTIONS = {
        :xml       => ["-x", "--xml PATH",     "Guarda el xml devuelto por AFIP en el archivo indicado,",
                                               "antes de procesarlo (opcional)."],
        :servicios => ["-s", "--servicios",    "Indica que lo que se está facturando corresponde",
                                               "a prestación de servicios (opcional)."]
    }
    OPTIONS = COMMON_OPTIONS.merge(AUTHENTICATION_OPTIONS.merge(AUT_OPTIONS))

    def initialize
      super()
      @options = WSFE::Runner::Options.new

      self.banner = "Modo de uso: wsfe [opciones] <servicio> [argumentos]"
      self.separator ""
      on_tail(*OPTIONS[:test])    { @options.test = true }
      on_tail(*OPTIONS[:version]) { mostrar_version_y_salir }
      on_tail(*OPTIONS[:info])    { mostrar_ayuda_y_salir }
    end

    def order!(argv, &blk)
      @argv = argv
      @options.argv = @argv.dup
      super(@argv)
      @options
    end

  protected
      
    def mostrar_version_y_salir
      puts ::WSFE::VERSION::DESCRIPTION and exit
    end

    def mostrar_ayuda_y_salir
      puts self and exit
    end      

  end
end
