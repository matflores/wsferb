# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Response::FECompTotXRequest < Response
      def format_record(record)
        "1%04d" % [ record[:reg_x_req] || 0 ]
      end

      def records
        @records ||= [ result ]
      end

      def result
        response[:fe_comp_tot_x_request_response][:fe_comp_tot_x_request_result] rescue {}
      end
    end
  end
end
