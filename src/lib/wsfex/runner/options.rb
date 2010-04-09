#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  module Runner
    class Options
      attr_accessor :cuit, :ticket, :cert, :key, :out, :log, :id, :servicios
        
      def cuit=(cuit)
        @cuit = cuit
        @cert ||= "./#{@cuit}.crt"
        @key ||= "./#{@cuit}.key"
        @log ||= "./#{@cuit}.log"
      end
    end
  end
end
