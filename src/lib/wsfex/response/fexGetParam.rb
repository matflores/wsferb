#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParam < Response
    def parse_result(result, response_key, result_key, container)
      container ||= :fex_result_get
      value_container = result.has_key?(container) ? result[container] : result

      value   = 'n/d'
      errCode = result[:fex_err][:err_code].to_i
      errMsg  = result[:fex_err][:err_msg]

      if errCode == 0
        formatted_records = format_records(value_container)
        value = formatted_records.join("\n")
      end

      return value, errCode, errMsg
    end

    def format_records(result)
      formatted_records = []
      records(result).each do |record|
        formatted_records << format_record(record)
      end
      formatted_records
    end

    def format_record(record)
      ''
    end

    def records(result)
      []
    end

    def to_s
      success? ? value : super
    end
  end
end
