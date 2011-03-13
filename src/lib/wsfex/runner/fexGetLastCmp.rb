#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXGetLastCmp < Base
      def main
        error("CUIT no informado") unless @options.cuit
        error("Tipo de comprobante no informado") unless @tipo_cbte
        error("Punto de venta no informado") unless @punto_vta
        ticket = obtieneTicket
        WSFEX::Client.getLastCmp(ticket, @tipo_cbte, @punto_vta, @options.log)
      end

      def load_options(argv)
        super
        argv.shift
        @tipo_cbte = argv.shift
        @punto_vta = argv.shift
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEXGetLastCmp <tipo-cbte> <punto-vta>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end

      def descripcion
<<__EOD__
     tipo-cbte                       Tipo de comprobante (ver FEXGetParamTipoCbte)
     punto-vta                       Punto de venta (ver FEXGetParamPtoVenta)

Retorna el ultimo numero otorgado para el cuit, tipo de comprobante y punto de venta especificados. En caso de no poseer ningun comprobante autorizado se devuelve un 0.

Ejemplos:

wsfe FEXGetLastCmp 19 0001 --cuit 20123456780
wsfe FEXGetLastCmp 19 0001 --cuit 20123456780 --test
wsfe FEXGetLastCmp 19 0001 --cuit 20123456780 --test --out ./resultado.ini
__EOD__
      end
    end
  end
end
