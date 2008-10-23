#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FEUltNroRequest < Base
      def main
        error("CUIT no informado") unless @options.cuit
        ticket = obtieneTicket
        WSFE::Client.recuperaUltNroTransaccion(ticket)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEUltNroRequest"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
