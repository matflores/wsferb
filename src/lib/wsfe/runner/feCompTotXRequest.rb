#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FECompTotXRequest < Base
      def main
        error("CUIT no informado") unless @options.cuit

        WSFE::Client.fe_comp_tot_x_request(ticket)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FECompTotXRequest"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
