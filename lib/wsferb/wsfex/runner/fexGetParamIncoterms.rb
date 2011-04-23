#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXGetParamIncoterms < Base
      def main
        error("CUIT no informado") unless @options.cuit

        WSFEX::Client.fex_get_param_incoterms(ticket)
      end

      def parse_options
        parser.banner = "Modo de uso: wsfex [opciones] FEXGetParamIncoterms"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end
    end
  end
end
