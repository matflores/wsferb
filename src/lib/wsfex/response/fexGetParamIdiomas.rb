#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamIdiomas < Response::GetParam
    def format_record(record)
      "%02d%-250s%-8s%-8s" % [ record.idi_Id,
                               record.idi_Ds,
                               record.idi_vig_desde,
                               record.idi_vig_hasta ]
    end

    def records(result)
      result.clsFEXResponse_Idi rescue []
    end
  end
end
