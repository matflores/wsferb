#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module AFIP
  class Response
    attr_accessor :response, :value, :err_code, :err_msg

    def initialize(response = {})
      @response = Hash === response ? response : response.to_hash
    end

    def success?
      err_code == 0
    end

    def to_s
      ["[Respuesta]", "valor=#{value}", "errCode=#{err_code}", "errMsg=#{err_msg}"].join("\n")
    end

    def self.parse(s)
      new.tap do |response|
        if s =~ /\[Respuesta\]\nvalor=(.*)\nerrCode=(.*)\nerrMsg=(.*)/
          response.value, response.err_code, response.err_msg = $1, $2, $3
        end
      end
    end
  end
end
