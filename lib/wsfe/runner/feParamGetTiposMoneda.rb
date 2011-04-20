#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FEParamGetTiposMoneda < Base
      def main
        error("CUIT no informado") unless @options.cuit

        WSFE::Client.fe_param_get_tipos_moneda(ticket)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEParamGetTiposMoneda"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
