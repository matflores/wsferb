#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FEParam < WSFErb::Response
      attr_accessor :records

      def format_record(record)
        ""
      end
    end
  end
end
