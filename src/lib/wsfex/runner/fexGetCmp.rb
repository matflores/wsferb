#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXGetCmp < Base
      def main
        error("CUIT no informado") unless @options.cuit
        error("Tipo de comprobante no informado") unless @tipo_cbte
        error("Punto de venta no informado") unless @punto_vta
        error("Nro de comprobante no informado") unless @nro_cbte
        ticket = obtieneTicket
        WSFEX::Client.getCmp(ticket, @tipo_cbte, @punto_vta, @nro_cbte, @salida, @options.log)
      end

      def load_options(argv)
        super
        argv.shift
        @tipo_cbte = argv.shift
        @punto_vta = argv.shift
        @nro_cbte  = argv.shift
        @salida    = RUBYSCRIPT2EXE.userdir(argv.shift)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEXGetCmp <tipo-cbte> <punto-vta> <nro-cbte> <salida>"
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

wsfe FEXGetCmp 19 0001 1234 comprobante.txt --cuit 20123456780
wsfe FEXGetCmp 19 0001 1234 comprobante.txt --cuit 20123456780 --test
__EOD__
      end
    end
  end
end
