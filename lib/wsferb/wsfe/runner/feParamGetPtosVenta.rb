#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FEParamGetPtosVenta < Base
      def main
        error("CUIT no informado") unless @options.cuit

        WSFE::Client.fe_param_get_ptos_venta(ticket)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEParamGetPtosVenta"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
