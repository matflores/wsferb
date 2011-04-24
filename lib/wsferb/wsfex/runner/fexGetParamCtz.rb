#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXGetParamCtz < Base
      def main
        error("CUIT no informado") unless @options.cuit
        error("Codigo de moneda no informado") unless @moneda

        WSFEX::Client.fex_get_param_ctz(ticket, @moneda)
      end

      def load_options(argv)
        super
        argv.shift
        @moneda = argv.shift
      end

      def parse_options
        parser.banner = "Modo de uso: wsfex [opciones] FEXGetParamCtz <moneda>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end

      def descripcion
<<__EOD__
     moneda                          Codigo de moneda (ver FEXGetParamMon)

Retorna la ultima cotizacion de la base de datos aduanera para la moneda especificada. Este valor es orientativo.

Ejemplos:

wsfex FEXGetParamCtz DOL --cuit 20123456780
wsfex FEXGetParamCtz 060 --cuit 20123456780 --test
wsfex FEXGetParamCtz 011 0001 --cuit 20123456780 --test --out ./resultado.ini
__EOD__
      end
    end
  end
end