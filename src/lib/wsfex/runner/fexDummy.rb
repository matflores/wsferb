#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXDummy < Base
      def main
        WSFEX::Client.fex_dummy
      end

      def parse_options
        parser.banner = "Modo de uso: wsfex [opciones] FEXDummy"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
