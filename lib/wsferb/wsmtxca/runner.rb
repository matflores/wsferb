#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/runner"

module WSFErb
  module WSMTXCA
    def self.run(options)
      Runner.new(options).run
    end

    def self.help_info
<<__EOD__
Modo de uso: wsmtxca <servicio> [argumentos] <opciones>

    servicio    Uno de los servicios provistos por el WSMTXCA de AFIP.
                Valores posibles:

                - dummy

                La sintaxis de las opciones y argumentos requeridos
                dependen del servicio a utilizar.
                Escriba wsmtxca <servicio> --help para obtener mayor
                informacion acerca de un servicio en particular.

                Visite http://docs.wsferb.com.ar para obtener
                documentacion actualizada y completa sobre cada
                uno de los servicios soportados.
__EOD__
    end

    def self.version_info
      Version::DESCRIPTION
    end

    class Runner < WSFErb::Runner
      def run_service
        case service
        when /dummy/i ; dummy
        else 
          return WSFE.version_info if options.version?
          return WSFE.help_info    if options.help?

          raise InvalidService, service
        end
      end

      def dummy
        Client.dummy
      end

      def script
        "wsmtxca"
      end
    end
  end
end
