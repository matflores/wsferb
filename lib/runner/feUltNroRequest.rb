module WSFE
  module Runner
    class FEUltNroRequest < Base
      def main
        info_exit unless @options.cuit
        info_exit unless @options.out
        ticket = obtieneTicket
        WSFE::Client.recuperaUltNroTransaccion(ticket).save(@options.out)
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
