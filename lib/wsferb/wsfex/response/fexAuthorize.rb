#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXAuthorize < Response
      def result
        response[:fex_authorize_response][:fex_authorize_result] rescue {}
      end

      def info
        result[:fex_result_auth] || {}
      end

      def formatted_records
        return [] unless success?

        fex               = Fex.new
        fex.cae           = info[:cae]
        fex.fecha_cae     = info[:fch_cbte]
        fex.fecha_vto_cae = info[:fch_venc_cae]
        fex.resultado     = info[:resultado]

        fex.to_s.split("\n")
      end
    end
  end
end
