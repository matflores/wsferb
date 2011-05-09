# encoding: utf-8
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

    def self.help_info
<<__EOD__
Modo de uso: wsfex <servicio> [argumentos] <opciones>

    servicio    Uno de los servicios provistos por el WSFEX de AFIP.
                Valores posibles:

                - FEXAuthorize
                - FEXCheckPermiso
                - FEXDummy
                - FEXGetCmp
                - FEXGetLastCmp
                - FEXGetLastId
                - FEXGetParamCtz
                - FEXGetParamDstCuit
                - FEXGetParamDstPais
                - FEXGetParamIncoterms
                - FEXGetParamIdiomas
                - FEXGetParamMon
                - FEXGetParamPtoVenta
                - FEXGetParamTipoCbte
                - FEXGetParamTipoExpo
                - FEXGetParamUMed

                La sintaxis de las opciones y argumentos requeridos
                dependen del servicio a utilizar.
                Escriba wsfex <servicio> --help para obtener mayor
                información acerca de un servicio en particular.

                Visite http://docs.wsferb.com.ar para obtener
                documentación actualizada y completa sobre cada
                uno de los servicios soportados.
__EOD__
    end

    def self.version_info
      Version::DESCRIPTION
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
          return WSFEX.version_info if options.version?
          return WSFEX.help_info    if options.help?

          raise InvalidService, service
        end
      end

      def fex_authorize
        usage "FEXAuthorize <Cbte>" if options.help?

        raise CuitMissing unless options.cuit

        cbte = options.arguments[0] || raise(WSFErb::ArgumentError, "Archivo con datos del comprobante a autorizar no informado")

        Client.fex_authorize(ticket, cbte)
      end

      def fex_check_permiso
        usage "FEXCheckPermiso <Permiso> <País>" if options.help?

        raise CuitMissing unless options.cuit

        permiso = options.arguments[0] || raise(WSFErb::ArgumentError, "Código de permiso de embarque no informado")
        pais    = options.arguments[1] || raise(WSFErb::ArgumentError, "Código de país de destino no informado")

        Client.fex_check_permiso(ticket, permiso, pais)
      end

      def fex_dummy
        Client.fex_dummy
      end

      def fex_get_cmp
        usage "FEXGetCmp <TipoCbte> <PtoVenta> <NroCbte>" if options.help?

        raise CuitMissing unless options.cuit

        tipo_cbte = options.arguments[0] || raise(WSFErb::ArgumentError, "Tipo de comprobante no informado")
        pto_venta = options.arguments[1] || raise(WSFErb::ArgumentError, "Punto de venta no informado")
        nro_cbte  = options.arguments[2] || raise(WSFErb::ArgumentError, "Número de comprobante no informado")

        Client.fex_get_cmp(ticket, tipo_cbte, pto_venta, nro_cbte)
      end

      def fex_get_last_cmp
        usage "FEXGetLastCmp <TipoCbte> <PtoVenta>" if options.help?

        raise CuitMissing unless options.cuit

        tipo_cbte = options.arguments[0] || raise(WSFErb::ArgumentError, "Tipo de comprobante no informado")
        pto_venta = options.arguments[1] || raise(WSFErb::ArgumentError, "Punto de venta no informado")

        Client.fex_get_last_cmp(ticket, tipo_cbte, pto_venta)
      end

      def fex_get_last_id
        usage "FEXGetLastId" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_last_id(ticket)
      end

      def fex_get_param_ctz
        usage "FEXGetParamCtz <Moneda>" if options.help?

        raise CuitMissing unless options.cuit

        moneda = options.arguments[0] || raise(WSFErb::ArgumentError, "Código de moneda no informado")

        Client.fex_get_param_ctz(ticket, moneda)
      end

      def fex_get_param_dst_cuit
        usage "FEXGetParamDstCuit" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_dst_cuit(ticket)
      end

      def fex_get_param_dst_pais
        usage "FEXGetParamDstPais" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_dst_pais(ticket)
      end

      def fex_get_param_idiomas
        usage "FEXGetParamIdiomas" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_idiomas(ticket)
      end

      def fex_get_param_incoterms
        usage "FEXGetParamIncoterms" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_incoterms(ticket)
      end

      def fex_get_param_mon
        usage "FEXGetParamMon" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_mon(ticket)
      end

      def fex_get_param_pto_venta
        usage "FEXGetParamPtoVenta" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_pto_venta(ticket)
      end

      def fex_get_param_tipo_cbte
        usage "FEXGetParamTipoCbte" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_tipo_cbte(ticket)
      end

      def fex_get_param_tipo_expo
        usage "FEXGetParamTipoExpo" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_tipo_expo(ticket)
      end

      def fex_get_param_u_med
        usage "FEXGetParamUMed" if options.help?

        raise CuitMissing unless options.cuit

        Client.fex_get_param_u_med(ticket)
      end

      def script
        "wsfex"
      end
    end
  end
end
