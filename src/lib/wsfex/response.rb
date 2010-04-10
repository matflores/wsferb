#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX

  class Response
    attr_accessor :value, :errCode, :errMsg

    def initialize(soap_response, result, container, fieldname)
      result = soap_response.respond_to?(result) ? soap_response.send(result) : nil
      if result
        container = result.respond_to?(container) ? result.send(container) : container
        value = container.respond_to?(fieldname) ? container.send(fieldname) : fieldname
        value = value.respond_to?(:value) ? value.value.to_i : value.to_i
        errCode = result.fEXErr.errCode.to_i
        errMsg = result.fEXErr.errMsg
      else
        value = 0
        errCode = -1
        errMsg = ''
      end
      @value = value
      @errCode = errCode
      @errMsg = errMsg
    end

    def to_s
      ["[Respuesta]", "valor=#{value}", "errCode=#{errCode}", "errMsg=#{errMsg}"].join("\n")
    end

    def save(file)
      File.open(file, 'w') { |f| f.puts(self) }
    end
  end

end
