module WSFE
  module Runner
    class FEUltNroRequest < Base
      def main
        info_exit unless @options.cuit
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
