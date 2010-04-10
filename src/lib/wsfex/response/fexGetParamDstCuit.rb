#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamDstCuit < Response::GetParam
    def format_record(record)
      "%-11s%-250s" % [ record.dST_CUIT, record.dST_Ds ]
    end

    def records(result)
      result.clsFEXResponse_DST_cuit rescue []
    end
  end
end
