#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  class Options
    attr_accessor :cuit, :ticket, :cert, :key, :out, :log
      
    def cuit=(cuit)
      @cuit = cuit
      @cert ||= "./#{@cuit}.crt"
      @key  ||= "./#{@cuit}.key"
      @log  ||= "./#{@cuit}.log"
    end
  end
end
