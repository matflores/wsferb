#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXAuthorize < Base
      def main
        error("CUIT no informado") unless @options.cuit
        error("Ubicacion del archivo de entrada no informada") unless @entrada
        error("Ubicacion del archivo de salida no informada") unless @salida
        ticket = obtieneTicket
        WSFEX::Client.authorize(ticket, @entrada, @salida, @options.log)
      end

      def load_options(argv)
        super
        argv.shift
        @entrada = RUBYSCRIPT2EXE.userdir(argv.shift)
        @salida  = RUBYSCRIPT2EXE.userdir(argv.shift)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEXAuthorize <entrada> <salida>"
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

wsfe FEXAuthorize entrada.txt salida.txt --cuit 20123456780
wsfe FEXAuthorize entrada.txt salida.txt --cuit 20123456780 --test --log cae.log
__EOD__
      end
    end
  end
end
