#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamIncoterms < Response::GetParam
    def format_record(record)
      "%-3s%-250s%-8s%-8s" % [ record.inc_Id,
                               record.inc_Ds,
                               record.inc_vig_desde,
                               record.inc_vig_hasta ]
    end

    def records(result)
      result.clsFEXResponse_Inc rescue []
    end
  end
end
