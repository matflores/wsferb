#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXGetLastId < Base
      def main
        error("CUIT no informado") unless @options.cuit
        ticket = obtieneTicket
        WSFEX::Client.getLastId(ticket, @options.log)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEXGetLastId"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
