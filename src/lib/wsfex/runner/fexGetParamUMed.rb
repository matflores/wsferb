#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXGetParamUMed < Base
      def main
        error("CUIT no informado") unless @options.cuit
        ticket = obtieneTicket
        WSFEX::Client.getParamUMed(ticket, @options.log)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEXGetParamUMed"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
