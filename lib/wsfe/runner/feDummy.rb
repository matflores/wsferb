#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FEDummy < Base
      def main
        WSFE::Client.test
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEDummy"
        parser.separator ""
        parse_common_options
      end
    end
  end
end
