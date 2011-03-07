#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamDstCuit < Response::GetParam
    def format_record(record)
      "%-11s%-250s" % [ record[:dst_cuit], record[:dst_ds] ]
    end

    def records(result)
      result[:cls_fex_response_dst_cuit] rescue []
    end
  end
end
