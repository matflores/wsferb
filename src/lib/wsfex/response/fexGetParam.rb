#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::FEXGetParam < Response
    attr_accessor :records

    def value
      @value ||= success? ? formatted_records.join("\n") : "n/d"
    end

    def formatted_records
      records.map { |record| format_record(record) }
    end

    def format_record(record)
      ''
    end

    def to_s
      success? ? value : super
    end
  end
end
