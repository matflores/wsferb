#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFE
  module Runner
    class Options
      attr_accessor :cuit, :ticket, :cert, :key, :out, :xml, :servicios
        
      def cuit=(cuit)
        @cuit = cuit
        @cert ||= "./#{@cuit}.crt"
        @key ||= "./#{@cuit}.key"
        @xml ||= "./#{@cuit}.xml"
      end
    end
  end
end
