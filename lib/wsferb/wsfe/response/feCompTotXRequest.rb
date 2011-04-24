# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'wsferb/response'

module WSFErb
  module WSFE
    class Response::FECompTotXRequest < Response
      def value
        result[:reg_x_req] rescue 0
      end

      def formatted_records
        ["1%04d" % value]
      end

      def result
        response[:fe_comp_tot_x_request_response][:fe_comp_tot_x_request_result] rescue {}
      end

#  def formatted_errors
#    errors.map { |e| ("E%06d%-512s" % [ e[:code], e[:message] ]).strip }
#  end

#      def formatted_errors
#        puts "*** FORMATTED ERRORS ***"
#        puts "*** #{result[:errors]}"
#        []
#      end

      def errors
        result[:errors][result[:errors][:err]]
      end

      def events
        [result[:events][:evt]]
      end
    end
  end
end
