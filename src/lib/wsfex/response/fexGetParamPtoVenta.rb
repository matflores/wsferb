#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFEX
  class Response::GetParamPtoVenta < Response::GetParam
    def format_record(record)
      "%04d%1s%-8s" % [ record.pve_Nro,
                        record.pve_Bloqueado,
                        record.pve_FchBaja ]
    end

    def records(result)
      result.clsFEXResponse_PtoVenta rescue []
    end
  end
end
