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
#  
#  <lote>          ubicacion del archivo con el lote a facturar 
#                  (ver formato RECE AFIP)
#  <salida>        ubicacion del archivo en el que se almacenaran los
#                  resultados de la operacion (ver formato RECE)
#
      end
    end
  end
end
