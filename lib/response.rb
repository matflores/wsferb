#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  class Response
    attr_accessor :response, :errors

    def initialize(response = {})
      @response = Hash === response ? response : response.to_hash
      @errors = []
    end

    def add_error(code, message)
      errors << { :code => code, :message => message }
    end

    def failed?
      errors.any? { |e| e[:code] > 0 }
    end

    def success?
      !failed?
    end

    def to_s
      errors.map { |e| ("E%06d%-512s" % [ e[:code], e[:message] ]).strip }.join("\n")
    end
  end
end
