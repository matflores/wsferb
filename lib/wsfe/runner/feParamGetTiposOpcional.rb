#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FEParamGetTiposOpcional < Base
      def main
        error("CUIT no informado") unless @options.cuit

        WSFE::Client.fe_param_get_tipos_opcional(ticket)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEParamGetTiposOpcional"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
