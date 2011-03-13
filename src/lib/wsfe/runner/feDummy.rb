#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FEDummy < Base
      def main
        WSFE::Client.fe_dummy
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEDummy"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
