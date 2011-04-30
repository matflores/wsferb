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
          raise InvalidService, service
        end
      end

      def fe_caea_consultar
      end

      def fe_caea_reg_informativo
      end

      def fe_caea_sin_movimiento_consultar
      end

      def fe_caea_sin_movimiento_informar
      end

      def fe_caea_solicitar
      end

      def fe_cae_solicitar
      end

      def fe_comp_consultar
      end

      def fe_comp_tot_x_request
        usage "FECompTotXRequest" if options.help?

        raise CuitMissing unless options.cuit

        Client.fe_comp_tot_x_request(ticket)
      end

      def fe_comp_ultimo_autorizado
        usage "FECompUltimoAutorizado <TipoCbte> <PuntoVta>" if options.help?

        raise CuitMissing unless options.cuit

        tipo_cbte = options.arguments[0]
        punto_vta = options.arguments[1]

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
