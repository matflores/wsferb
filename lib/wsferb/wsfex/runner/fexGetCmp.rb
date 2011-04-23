#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXGetCmp < Base
      def main
        error("CUIT no informado") unless @options.cuit
        error("Tipo de comprobante no informado") unless @tipo_cbte
        error("Punto de venta no informado") unless @punto_vta
        error("Nro de comprobante no informado") unless @nro_cbte

        WSFEX::Client.fex_get_cmp(ticket, @tipo_cbte, @punto_vta, @nro_cbte, @salida)
      end

      def load_options(argv)
        super
        argv.shift
        @tipo_cbte = argv.shift
        @punto_vta = argv.shift
        @nro_cbte  = argv.shift
        @salida    = argv.shift
      end

      def parse_options
        parser.banner = "Modo de uso: wsfex [opciones] FEXGetCmp <tipo-cbte> <punto-vta> <nro-cbte> <salida>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end

      def descripcion
<<__EOD__
     tipo-cbte                       Tipo de comprobante (ver FEXGetParamTipoCbte)
     punto-vta                       Punto de venta (ver FEXGetParamPtoVenta)
     nro-cbte                        Nro de comprobante
     salida                          Ubicacion del archivo en el que se almacenaran
                                     los datos del comprobante especificado

Retorna los detalles de un comprobante ya enviado y autorizado.

Ejemplos:

wsfex FEXGetCmp 19 0001 1234 comprobante.txt --cuit 20123456780
wsfex FEXGetCmp 19 0001 1234 comprobante.txt --cuit 20123456780 --test
__EOD__
      end
    end
  end
end
