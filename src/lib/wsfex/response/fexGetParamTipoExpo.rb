#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamTipoExpo < Response::GetParam
    def format_record(record)
      "%02d%-250s%-8s%-8s" % [ record.tex_Id,
                               record.tex_Ds,
                               record.tex_vig_desde,
                               record.tex_vig_hasta ]
    end

    def records(result)
      result.clsFEXResponse_Tex rescue []
    end
  end
end
