#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FECompUltimoAutorizado < Base
      def main
        error("CUIT no informado") unless @options.cuit
        error("Tipo de comprobante no informado") unless @tipo_cbte
        error("Punto de venta no informado") unless @punto_vta

        WSFE::Client.fe_comp_ultimo_autorizado(ticket, @tipo_cbte, @punto_vta)
      end

      def load_options(argv)
        super
        argv.shift
        @tipo_cbte = argv.shift
        @punto_vta = argv.shift
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FECompUltimoAutorizado <tipo-cbte> <punto-vta>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end

      def descripcion
<<__EOD__
     tipo-cbte                       Tipo de comprobante (ver FEGetParamTipoCbte)
     punto-vta                       Punto de venta (ver FEGetParamPtoVenta)

Retorna el ultimo numero otorgado para el cuit, tipo de comprobante y punto de venta especificados. En caso de no poseer ningun comprobante autorizado devuelve 0.

Ejemplos:

wsfe FECompUltimoAutorizado 01 0001 --cuit 20123456780
wsfe FECompUltimoAutorizado 01 0001 --cuit 20123456780 --test
wsfe FECompUltimoAutorizado 01 0001 --cuit 20123456780 --test --out ./resultado.txt
__EOD__
      end
    end
  end
end
