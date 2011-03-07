#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamPtoVenta < Response::GetParam
    def format_record(record)
      "%04d%1s%-8s" % [ record[:pve_nro],
                        record[:pve_bloqueado],
                        record[:pve_fch_baja] ]
    end

    def records(result)
      result[:cls_fex_response_pto_venta] rescue []
    end
  end
end
