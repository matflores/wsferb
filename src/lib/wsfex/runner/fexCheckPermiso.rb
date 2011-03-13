#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class FEXCheckPermiso < Base
      def main
        error("CUIT no informado") unless @options.cuit
        error("Codigo de permiso de embarque no informado") unless @permiso
        error("Codigo de pais de destino no informado") unless @pais
        ticket = obtieneTicket
        WSFEX::Client.checkPermiso(ticket, @permiso, @pais, @options.log)
      end

      def load_options(argv)
        super
        argv.shift
        @permiso = argv.shift
        @pais = argv.shift
      end

      def parse_options
        parser.banner = "Modo de uso: wsfe [opciones] FEXCheckPermiso <permiso> <destino>"
        parser.separator ""
        parse_authentication_options
        parse_common_options
      end

      def descripcion
<<__EOD__
     permiso                         Codigo de permiso de embarque
     destino                         Codigo de pais de destino (ver FEXGetParamDstPais)

Verifica la existencia de un permiso de embarque. Devuelve OK si la informacion de la relacion permiso de embarque/pais de destino esta registrada en la base de datos aduanera.

Ejemplos:

wsfe FEXCheckPermiso 11111 310 --cuit 20123456780
wsfe FEXCheckPermiso 11111 310 --cuit 20123456780 --test
wsfe FEXCheckPermiso 11111 310 --cuit 20123456780 --test --out ./resultado.ini
__EOD__
      end
    end
  end
end
