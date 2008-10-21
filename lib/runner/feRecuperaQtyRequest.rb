module WSFE
  module Runner
    class FERecuperaQTYRequest < Base
      def main
        info_exit unless @options.cuit
        info_exit unless @options.out
        ticket = obtieneTicket
        WSFE::Client.recuperaMaxQty(ticket).save(@options.out)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FERecuperaQTYRequest"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
