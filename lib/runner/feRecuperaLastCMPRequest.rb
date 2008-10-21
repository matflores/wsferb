module WSFE
  module Runner
    class FERecuperaLastCMPRequest < Base
      def main
        info_exit unless @options.cuit
        info_exit unless @punto_vta
        info_exit unless @tipo_cbte
        ticket = obtieneTicket
        WSFE::Client.recuperaUltNroCbte(ticket, @punto_vta, @tipo_cbte)
      end

      def load_options(argv)
        super
        info_exit if argv.size < 3
        @tipo_cbte = argv[1].dup
        @punto_vta = argv[2].dup
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FERecuperaLastCMPRequest <tipo-cbte> <punto-vta>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
#  <tipo-cbte>     tipo de comprobante (ver tabla AFIP)
#  <punto-vta>     punto de venta
      end

      def descripcion
<<__EOD__
     tipo-cbte                       Tipo de comprobante (ver tabla AFIP)
     punto-vta                       Punto de venta

Retorna el último número otorgado para el cuit, tipo de comprobante y punto de venta especificados. En caso de no poseer ningún comprobante autorizado se devuelve un 0.

Ejemplos:

wsfe FERecuperaLastCMPRequest 01 0001 --cuit 20123456780
wsfe FERecuperaLastCMPRequest 01 0001 --cuit 20123456780 --test
wsfe FERecuperaLastCMPRequest 01 0001 --cuit 20123456780 --test --out ./resultado.ini
__EOD__
      end
    end
  end
end
