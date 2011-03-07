#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamDstPais < Response::GetParam
    def format_record(record)
      "%-3s%-250s" % [ record[:dst_codigo], record[:dst_ds] ]
    end

    def records(result)
      result[:cls_fex_response_dst_pais] rescue []
    end
  end
end
