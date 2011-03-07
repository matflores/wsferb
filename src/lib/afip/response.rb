#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module AFIP
  class Response
    attr_accessor :value, :errCode, :errMsg

    def initialize(soap_response={}, response_key=nil, result_key=:nil, container=nil)
      response = Hash === soap_response ? soap_response : soap_response.to_hash
      response = response[response_key] if response_key
      result = response[result_key] if response
      if result
        @value, @errCode, @errMsg = parse_result(result, response_key, result_key, container)
      else
        @value, @errCode, @errMsg = [0, -1, '']
      end
    end

    def parse_result(result, response_key, result_key, container)
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
