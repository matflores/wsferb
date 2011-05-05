#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "wsferb/runner"

module WSFErb
  module WSFE
    def self.run(options)
      Runner.new(options).run
    end

    def self.help_info
<<__EOD__
Modo de uso: wsfe <servicio> [argumentos] <opciones>

     servicio                        Uno de los servicios provistos por el WSFE de AFIP.
                                     Valores posibles:

                                       - FECAEAConsultar
                                       - FECAEARegInformativo
                                       - FECAEASinMovimientoConsultar
                                       - FECAEASinMovimientoInformar
                                       - FECAEASolicitar
                                       - FECAESolicitar
                                       - FECompConsultar
                                       - FECompTotXRequest
                                       - FECompUltimoAutorizado
                                       - FEDummy
                                       - FEParamGetCotizacion
                                       - FEParamGetPtosVenta
                                       - FEParamGetTiposCbte
                                       - FEParamGetTiposConcepto
                                       - FEParamGetTiposDoc
                                       - FEParamGetTiposIva
                                       - FEParamGetTiposMonedas
                                       - FEParamGetTiposOpcional
                                       - FEParamGetTiposTributos

                                     La sintaxis de las opciones y argumentos requeridos 
                                     dependen del servicio a utilizar.
                                     Escriba wsfe <servicio> --help para obtener mayor
                                     informacion acerca de un servicio en particular.

                                     Visite http://docs.wsferb.com.ar para obtener
                                     documentacion actualizada y completa sobre cada
                                     uno de los servicios soportados.
__EOD__
    end

    def self.version_info
      Version::DESCRIPTION
    end

    class Runner < WSFErb::Runner
      def run_service
        case service
        when /fecaeaconsultar/i              ; fe_caea_consultar
        when /fecaeareginformativo/i         ; fe_caea_reg_informativo
        when /fecaeasinmovimientoconsultar/i ; fe_caea_sin_movimiento_consultar
        when /fecaeasinmovimientoinformar/i  ; fe_caea_sin_movimiento_informar
        when /fecaeasolicitar/i              ; fe_caea_solicitar
        when /fecaesolicitar/i               ; fe_cae_solicitar
        when /fecompconsultar/i              ; fe_comp_consultar
        when /fecomptotxrequest/i            ; fe_comp_tot_x_request
        when /fecompultimoautorizado/i       ; fe_comp_ultimo_autorizado
        when /fedummy/i                      ; fe_dummy
        when /feparamgetcotizacion/i         ; fe_param_get_cotizacion
        when /feparamgetptosventa/i          ; fe_param_get_ptos_venta
        when /feparamgettiposcbte/i          ; fe_param_get_tipos_cbte
        when /feparamgettiposconcepto/i      ; fe_param_get_tipos_concepto
        when /feparamgettiposdoc/i           ; fe_param_get_tipos_doc
        when /feparamgettiposiva/i           ; fe_param_get_tipos_iva
        when /feparamgettiposmonedas/i       ; fe_param_get_tipos_monedas
        when /feparamgettiposopcional/i      ; fe_param_get_tipos_opcional
        when /feparamgettipostributos/i      ; fe_param_get_tipos_tributos
        else 
          return WSFE.version_info if options.version?
          return WSFE.help_info    if options.help?

          raise InvalidService, service
        end
      end

      def fe_caea_consultar
        usage "FECAEAConsultar <Periodo> <Quincena>" if options.help?

        raise CuitMissing unless options.cuit

        periodo  = options.arguments[0] || raise(WSFErb::ArgumentError, "Periodo no informado")
        quincena = options.arguments[1] || raise(WSFErb::ArgumentError, "Quincena no informada")

        Client.fe_caea_consultar(ticket, periodo, quincena)
      end

      def fe_caea_reg_informativo
      end

      def fe_caea_sin_movimiento_consultar
        usage "FECAEASinMovimientoConsultar <CAEA> <PuntoVta>" if options.help?

        raise CuitMissing unless options.cuit

        caea      = options.arguments[0] || raise(WSFErb::ArgumentError, "CAEA no informado")
        punto_vta = options.arguments[1] || raise(WSFErb::ArgumentError, "Punto de venta no informado")

        Client.fe_caea_sin_movimiento_consultar(ticket, caea, punto_vta)
      end

      def fe_caea_sin_movimiento_informar
        usage "FECAEASinMovimientoInformar <CAEA> <PuntoVta>" if options.help?

        raise CuitMissing unless options.cuit

        caea      = options.arguments[0] || raise(WSFErb::ArgumentError, "CAEA no informado")
        punto_vta = options.arguments[1] || raise(WSFErb::ArgumentError, "Punto de venta no informado")

        Client.fe_caea_sin_movimiento_informar(ticket, caea, punto_vta)
      end

      def fe_caea_solicitar
        usage "FECAEASolicitar <Periodo> <Quincena>" if options.help?

        raise CuitMissing unless options.cuit

        periodo  = options.arguments[0] || raise(WSFErb::ArgumentError, "Periodo no informado")
        quincena = options.arguments[1] || raise(WSFErb::ArgumentError, "Quincena no informada")

        Client.fe_caea_solicitar(ticket, periodo, quincena)
      end

      def fe_cae_solicitar
      end

      def fe_comp_consultar
        usage "FECompConsultar <TipoCbte> <PuntoVta> <NroCbte>" if options.help?

        raise CuitMissing unless options.cuit

        tipo_cbte = options.arguments[0] || raise(WSFErb::ArgumentError, "Tipo de comprobante no informado")
        punto_vta = options.arguments[1] || raise(WSFErb::ArgumentError, "Punto de venta no informado")
        nro_cbte  = options.arguments[2] || raise(WSFErb::ArgumentError, "Numero de comprobante no informado")

        Client.fe_comp_consultar(ticket, tipo_cbte, punto_vta, nro_cbte)
      end

      def fe_comp_tot_x_request
        usage "FECompTotXRequest" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_comp_tot_x_request(ticket)
      end

      def fe_comp_ultimo_autorizado
        usage "FECompUltimoAutorizado <TipoCbte> <PuntoVta>" if options.help?

        raise CuitMissing unless options.cuit

        tipo_cbte = options.arguments[0] || raise(WSFErb::ArgumentError, "Tipo de comprobante no informado")
        punto_vta = options.arguments[1] || raise(WSFErb::ArgumentError, "Punto de venta no informado")

        Client.fe_comp_ultimo_autorizado(ticket, tipo_cbte, punto_vta)
      end

      def fe_dummy
        Client.fe_dummy
      end

      def fe_param_get_cotizacion
        usage "FEParamGetCotizacion" if options.help?

        raise CuitMissing unless options.cuit

        moneda = options.arguments[0]

        Client.fe_param_get_cotizacion(ticket, moneda)
      end

      def fe_param_get_ptos_venta
        usage "FEParamGetPtosVenta" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_param_get_ptos_venta(ticket)
      end

      def fe_param_get_tipos_cbte
        usage "FEParamGetTiposCbte" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_param_get_tipos_cbte(ticket)
      end

      def fe_param_get_tipos_concepto
        usage "FEParamGetTiposConcepto" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_param_get_tipos_concepto(ticket)
      end

      def fe_param_get_tipos_doc
        usage "FEParamGetTiposDoc" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_param_get_tipos_doc(ticket)
      end

      def fe_param_get_tipos_iva
        usage "FEParamGetTiposIva" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_param_get_tipos_iva(ticket)
      end

      def fe_param_get_tipos_monedas
        usage "FEParamGetTiposMonedas" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_param_get_tipos_monedas(ticket)
      end

      def fe_param_get_tipos_opcional
        usage "FEParamGetTiposOpcional" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_param_get_tipos_opcional(ticket)
      end

      def fe_param_get_tipos_tributos
        usage "FEParamGetTiposTributos" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_param_get_tipos_tributos(ticket)
      end

      def script
        "wsfe"
      end
    end
  end
end
