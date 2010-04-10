#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamUMed < Response::GetParam
    def format_record(record)
      "%02d%-250s%-8s%-8s" % [ record.umed_Id,
                               record.umed_Ds,
                               record.umed_vig_desde,
                               record.umed_vig_hasta ]
    end

    def records(result)
      result.clsFEXResponse_UMed rescue []
    end
  end
end
