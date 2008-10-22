#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FEConsultaCAERequest < Base
      def main
        info_exit unless @options.cuit
        info_exit unless @cae && @cuit_emisor && @tipo_cbte && @punto_vta && @nro_cbte && @total && @fecha
        ticket = obtieneTicket
        WSFE::Client.verificaCAE(ticket, @cae, @cuit_emisor, @punto_vta, @tipo_cbte, @nro_cbte, @total, @fecha)
      end

      def load_options(argv)
        super
        info_exit if argv.size < 8
        @cae = argv[1].dup
        @cuit_emisor = argv[2].dup
        @tipo_cbte = argv[3].dup
        @punto_vta = argv[4].dup
        @nro_cbte = argv[5].dup
        @total = argv[6].dup
        @fecha = argv[7].dup
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEConsultaCAERequest <cae> <cuit-emisor> <tipo-cbte> <punto-vta> <nro-cbte> <total> <fecha>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end

      def descripcion
<<__EOD__
     cae                             CAE a verificar
     cuit-emisor                     CUIT emisor del comprobante
     tipo-cbte                       Tipo de comprobante (ver tabla AFIP)
     punto-vta                       Punto de venta
     nro-cbte                        Numero de comrobante
     total                           Importe total de la operacion o lote
     fecha                           Fecha del comprobante (AAAAMMDD)

Verifica la validez de un CAE. Recibe el cuit emisor, el tipo y numero de comprobante, el punto de venta, el importe total de la operacion, la fecha de comprobante y el CAE a verificar, y retorna 1 si el CAE indicado es valido, o 0 en caso contrario.

Ejemplos:

wsfe FEConsultaCAERequest 20111111110 01 0001 12345678 1210 123456789012345 20081001 --cuit 20123456780
wsfe FEConsultaCAERequest 20111111110 01 0001 12345678 1210 123456789012345 20081001 --cuit 20123456780 --test
wsfe FEConsultaCAERequest 20111111110 01 0001 12345678 1210 123456789012345 20081001 --cuit 20123456780 --test --out ./resultado.ini
__EOD__
      end
    end
  end
end
