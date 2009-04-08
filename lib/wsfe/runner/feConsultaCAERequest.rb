#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FEConsultaCAERequest < Base
      def main
        error("CUIT no informado") unless @options.cuit
        error("CAE a validar no informado") unless @cae
        error("CUIT emisor no informado") unless @cuit_emisor
        error("Tipo de comprobante no informado") unless @tipo_cbte
        error("Punto de venta no informado") unless @punto_vta
        error("Numero de comprobante no informado") unless @nro_cbte
        error("Importe total no informado") unless @total
        error("Fecha no informada") unless @fecha
        ticket = obtieneTicket
        WSFE::Client.verificaCAE(ticket, @cae, @cuit_emisor, @punto_vta, @tipo_cbte, @nro_cbte, @total, @fecha)
      end

      def load_options(argv)
        super
        argv.shift
        @cae = argv.shift
        @cuit_emisor = argv.shift
        @tipo_cbte = argv.shift
        @punto_vta = argv.shift
        @nro_cbte = argv.shift
        @total = argv.shift
        @fecha = argv.shift
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

wsfe FEConsultaCAERequest 123456789012345 20111111110 01 0001 12345678 1210.50 20081001 --cuit 20123456780
wsfe FEConsultaCAERequest 123456789012345 20111111110 01 0001 12345678 1210.50 20081001 --cuit 20123456780 --test
wsfe FEConsultaCAERequest 123456789012345 20111111110 01 0001 12345678 1210.50 20081001 --cuit 20123456780 --test --out ./resultado.ini
__EOD__
      end
    end
  end
end
