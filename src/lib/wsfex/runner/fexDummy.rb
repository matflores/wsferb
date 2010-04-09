#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXDummy < Base
      def main
        WSFEX::Client.test(@options.log)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEXDummy"
        parser.separator ""
        parse_common_options
      end
    end
  end
end
