#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamDstPais < Response::GetParam
    def format_record(record)
      [ record.dST_Codigo % "%03s",
        record.dST_Ds     % "%250s" ].join
    end

    def records(result)
      result.clsFEXResponse_DST_pais
    end
  end
end
