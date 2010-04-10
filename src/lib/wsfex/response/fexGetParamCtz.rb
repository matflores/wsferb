#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamCtz < Response::GetParam
    def format_record(record)
      "%-3s%-250s" % [ record.dST_Codigo, record.dST_Ds ]
    end

    def records(result)
      result.clsFEXResponse_DST_pais rescue []
    end
  end
end
