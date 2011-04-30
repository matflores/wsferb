#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/runner"

module WSFErb
  module WSFEX
    def self.run(options)
      Runner.new(options).run
    end

    class Runner < WSFErb::Runner
      def run_service
        case service
        when /fexauthorize/i         ; fex_authorize
        when /fexcheckpermiso/i      ; fex_check_permiso
        when /fexdummy/i             ; fex_dummy
        when /fexgetcmp/i            ; fex_get_cmp
        when /fexgetlastcmp/i        ; fex_get_last_cmp
        when /fexgetlastid/i         ; fex_get_last_id
        when /fexgetparamctz/i       ; fex_get_param_ctz
        when /fexgetparamdstcuit/i   ; fex_get_param_dst_cuit
        when /fexgetparamdstpais/i   ; fex_get_param_dst_pais
        when /fexgetparamidiomas/i   ; fex_get_param_idiomas
        when /fexgetparamincoterms/i ; fex_get_param_incoterms
        when /fexgetparammon/i       ; fex_get_param_mon
        when /fexgetparamptoventa/i  ; fex_get_param_pto_venta
        when /fexgetparamtipocbte/i  ; fex_get_param_tipo_cbte
        when /fexgetparamtipoexpo/i  ; fex_get_param_tipo_expo
        when /fexgetparamumed/i      ; fex_get_param_u_med
        else 
          raise InvalidService, service
        end
      end

      def fex_authorize
        usage "FEXAuthorize <Cbte>" if options.help?

        raise CuitMissing unless options.cuit

        cbte = options.arguments[0] || raise(WSFErb::ArgumentError, "Cbte no informado")

        Client.fex_authorize(ticket, cbte)
      end

      def fex_check_permiso
        usage "FEXCheckPermiso <Permiso> <Pais>" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        permiso = options.arguments[0] || raise(ArgumentError, "")
        pais    = options.arguments[1]

        Client.fex_check_permiso(ticket, permiso, pais)
      end

      def fex_dummy
        Client.fex_dummy
      end

      def fex_get_cmp
        usage "FEXGetCmp <TipoCbte> <PtoVenta> <NroCbte>" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        tipo_cbte = options.arguments[0]
        pto_venta = options.arguments[1]
        nro_cbte  = options.arguments[2]

        Client.fex_get_cmp(ticket, tipo_cbte, pto_venta, nro_cbte)
      end

      def fex_get_last_cmp
        usage "FEXGetLastCmp <TipoCbte> <PtoVenta>" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        tipo_cbte = options.arguments[0]
        pto_venta = options.arguments[1]

        Client.fex_get_last_cmp(ticket, tipo_cbte, pto_venta)
      end

      def fex_get_last_id
        usage "FEXGetLastId" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        Client.fex_get_last_id(ticket)
      end

      def fex_get_param_ctz
        usage "FEXGetParamCtz <Moneda>" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        moneda = options.arguments[0]

        Client.fex_get_param_ctz(ticket, moneda)
      end

      def fex_get_param_dst_cuit
        usage "FEXGetParamDstCuit" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        Client.fex_get_param_dst_cuit(ticket)
      end

      def fex_get_param_dst_pais
        usage "FEXGetParamDstPais" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        Client.fex_get_param_dst_pais(ticket)
      end

      def fex_get_param_idiomas
        usage "FEXGetParamIdiomas" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        Client.fex_get_param_idiomas(ticket)
      end

      def fex_get_param_incoterms
        usage "FEXGetParamIncoterms" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        Client.fex_get_param_incoterms(ticket)
      end

      def fex_get_param_mon
        usage "FEXGetParamMon" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        Client.fex_get_param_mon(ticket)
      end

      def fex_get_param_pto_venta
        usage "FEXGetParamPtoVenta" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        Client.fex_get_param_pto_venta(ticket)
      end

      def fex_get_param_tipo_cbte
        usage "FEXGetParamTipoCbte" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_tipo_cbte(ticket)
      end

      def fex_get_param_tipo_expo
        usage "FEXGetParamTipoExpo" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        Client.fex_get_param_tipo_expo(ticket)
      end

      def fex_get_param_u_med
        usage "FEXGetParamUMed" if options.help?

        raise(ArgumentError, "CUIT missing") unless options.cuit

        Client.fex_get_param_u_med(ticket)
      end

      def script
        "wsfex"
      end
    end
  end
end
