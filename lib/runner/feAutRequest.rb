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
        @lote = argv[1].dup
        @salida = argv[2].dup
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEAutRequest <lote> <salida>"
        parser.separator ""
        parse_authentication_options
        parser.on(*OPTIONS[:xml])       { |xml| @options.xml = xml }
        parser.on(*OPTIONS[:servicios]) { @options.servicios = true }
        parse_common_options
      end

      def descripcion
<<__EOD__
     lote                            Ubicación del archivo con el lote a facturar 
                                     (ver formato RECE AFIP)
     salida                          Ubicación del archivo en el que se almacenarán 
                                     los resultados de la operación 
                                     (ver formato RECE AFIP)
     
Retorna la información de la factura/lote de ingreso agregándole el CAE otorgado. Ante cualquier anomalía se incluyen también los códigos de error correspondientes.

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
