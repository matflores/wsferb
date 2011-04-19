#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class Wsfe < Base
      def run(argv)
        args = argv.dup
        load_options(argv)
        service = find_service(argv.shift)
        service ? service.run(args) : usage_exit
      end

      def find_service(service_name)
        service_name = WSFE::Runner.constants.detect { |constant| constant =~ /#{service_name}/i }
        service_name ? WSFE::Runner.const_get(service_name) : nil
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] <servicio> [argumentos]"
        parser.separator ""
        parse_authentication_options
        parse_other_options
        parse_common_options
      end

      def info_exit
      end      

      def usage_exit
        puts descripcion
        exit 1
      end      
      
      def descripcion
<<__EOD__
Modo de uso: wsfe [opciones] <servicio> [argumentos]

     servicio                        Uno de los servicios provistos por el WSFE de AFIP.
                                     Valores posibles:
                                       - FEDummy
                                       - FECompUltimoAutorizado

                                     La sintaxis de las opciones y argumentos requeridos 
                                     dependen del servicio a utilizar.
                                     Escriba wsfe <servicio> --help para obtener mayor
                                     informacion acerca de un servicio en particular.
__EOD__
      end
    end
  end
end
