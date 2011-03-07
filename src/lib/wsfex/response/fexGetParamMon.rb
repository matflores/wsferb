#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamMon < Response::GetParam
    def format_record(record)
      "%-3s%-250s%-8s%-8s" % [ record[:mon_id],
                               record[:mon_ds],
                               record[:mon_vig_desde],
                               record[:mon_vig_hasta] ]
    end

    def records(result)
      result[:cls_fex_response_mon] rescue []
    end
  end
end
