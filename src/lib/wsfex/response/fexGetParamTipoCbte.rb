#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamTipoCbte < Response::GetParam
    def format_record(record)
      "%02d%-250s%-8s%-8s" % [ record.cbte_Id,
                               record.cbte_Ds,
                               record.cbte_vig_desde,
                               record.cbte_vig_hasta ]
    end

    def records(result)
      result.clsFEXResponse_Tipo_Cbte rescue []
    end
  end
end
