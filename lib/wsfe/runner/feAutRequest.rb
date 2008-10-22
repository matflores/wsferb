#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FEAutRequest < Base
      def main
        info_exit unless @options.cuit
        info_exit unless @options.id
        info_exit unless @lote
        info_exit unless @salida
        ticket = obtieneTicket
        WSFE::Client.factura_lote(ticket, @options.id, @options.cuit, @options.servicios, @lote, @salida, @options.xml)
      end

      def load_options(argv)
        super
        info_exit if argv.size < 3
        #@lote = RUBYSCRIPT2EXE.userdir(argv[1])
        @lote = argv[1]
        #@salida = RUBYSCRIPT2EXE.userdir(argv[2])
        @salida = argv[2]
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEAutRequest <lote> <salida>"
        parser.separator ""
        parse_authentication_options
        parse_other_options
        parse_common_options
      end

      def descripcion
<<__EOD__
     lote                            Ubicacion del archivo con el lote a facturar 
                                     (ver formato RECE AFIP)
     salida                          Ubicacion del archivo en el que se almacenaran 
                                     los resultados de la operacion 
                                     (ver formato RECE AFIP)
     
Retorna la informacion de la factura/lote de ingreso agregandole el CAE otorgado. Ante cualquier anomalia se incluyen tambien los codigos de error correspondientes.

Ejemplos:

wsfe FEAutRequest lote1.txt cae_lote_1.txt --cuit 20123456780 --id 1234
wsfe FEAutRequest lote1.txt cae_lote_1.txt --cuit 20123456780 --id 1234 --xml cae_lote1.xml
wsfe FEAutRequest lote1.txt cae_lote_1.txt --cuit 20123456780 --id 1234 --test
wsfe FEAutRequest lote1.txt cae_lote_1.txt --cuit 20123456780 --id 1234 --xml cae_lote1.xml --test
wsfe FEAutRequest lote1.txt cae_lote_1.txt --cuit 20123456780 --id 1234 --servicios

__EOD__
      end
    end
  end
end
