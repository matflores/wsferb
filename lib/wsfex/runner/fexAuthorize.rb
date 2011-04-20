#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXAuthorize < Base
      def main
        raise "CUIT no informado" unless @options.cuit
        raise "Ubicacion del archivo de entrada no informada" unless @entrada
        error("Ubicacion del archivo de salida no informada") unless @salida

        WSFEX::Client.fex_authorize(ticket, @entrada, @salida)
      end

      def load_options(argv)
        super
        argv.shift
        @entrada = argv.shift
        @salida  = argv.shift
      end

      def parse_options
        parser.banner = "Modo de uso: wsfex [opciones] FEXAuthorize <entrada> <salida>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end

      def descripcion
<<__EOD__
     entrada                         Ubicacion del archivo con los datos del 
                                     comprobante a autorizar
     salida                          Ubicacion del archivo en el que se almacenaran
                                     los resultados de la operacion

Recibe la informacion del comprobante a autorizar y lo procesa, retornando el CAE asignado. Ante cualquier anomalia se incluyen tambien los codigos de error correspondientes.

Ejemplos:

wsfex FEXAuthorize entrada.txt salida.txt --cuit 20123456780
wsfex FEXAuthorize entrada.txt salida.txt --cuit 20123456780 --test --log cae.log
__EOD__
      end
    end
  end
end
