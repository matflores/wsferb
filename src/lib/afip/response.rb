#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module AFIP
  class Response
    attr_accessor :value, :errCode, :errMsg

    def initialize(soap_response='', result=:nil, fieldname=:nil, container=nil)
      result = soap_response.respond_to?(result) ? soap_response.send(result) : nil
      if result
        @value, @errCode, @errMsg = parse_result(result, fieldname, container)
      else
        @value, @errCode, @errMsg = [0, -1, '']
      end
    end

    def parse_result(result, fieldname, container)
      return 0, -1, ''
    end

    def success?
      errCode == 0
    end

    def to_s
      ["[Respuesta]", "valor=#{value}", "errCode=#{errCode}", "errMsg=#{errMsg}"].join("\n")
    end

    def self.parse(s)
      new.tap do |response|
        if s =~ /\[Respuesta\]\nvalor=(.*)\nerrCode=(.*)\nerrMsg=(.*)/
          response.value, response.errCode, response.errMsg = $1, $2, $3
        end
      end
    end
  end
end
