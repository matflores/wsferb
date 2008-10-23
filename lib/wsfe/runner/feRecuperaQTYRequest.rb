#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class FERecuperaQTYRequest < Base
      def main
        error("CUIT no informado") unless @options.cuit
        ticket = obtieneTicket
        WSFE::Client.recuperaMaxQty(ticket)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FERecuperaQTYRequest"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
      
      def descripcion
<<__EOD__
Retorna la cantidad maxima de registros a incluir en el detalle del servicio facturador (FEAutRequest).

Ejemplos:

wsfe FERecuperaQTYRequest --cuit 20123456780
wsfe FERecuperaQTYRequest --cuit 20123456780 --test
wsfe FERecuperaQTYRequest --cuit 20123456780 --test --out ./resultado.ini

__EOD__
      end
    end
  end
end
