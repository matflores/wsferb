#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXGetParamCtz < Base
      def main
        error("CUIT no informado") unless @options.cuit
        error("Codigo de moneda no informado") unless @moneda
        ticket = obtieneTicket
        WSFEX::Client.getParamCtz(ticket, @moneda, @options.log)
      end

      def load_options(argv)
        super
        argv.shift
        @moneda = argv.shift
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEXGetParamCtz <moneda>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end

      def descripcion
<<__EOD__
     moneda                          Codigo de moneda (ver FEXGetParamMon)

Retorna la ultima cotizacion de la base de datos aduanera para la moneda especificada. Este valor es orientativo.

Ejemplos:

wsfe FEGetParamCtz DOL --cuit 20123456780
wsfe FEGetParamCtz 060 --cuit 20123456780 --test
wsfe FEGetParamCtz 011 0001 --cuit 20123456780 --test --out ./resultado.ini
__EOD__
      end
    end
  end
end
