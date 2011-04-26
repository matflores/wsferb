#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FEParam < Response
      attr_accessor :records

      def formatted_records
        records.map { |record| format_record(record) }
      end

      def format_record(record)
        ''
      end
    end
  end
end
