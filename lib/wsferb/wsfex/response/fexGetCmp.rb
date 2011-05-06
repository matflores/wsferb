#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFEX
    class Response::FEXGetCmp < Response
      def result
        response[:fex_get_cmp_response][:fex_get_cmp_result] rescue {}
      end

      def info
        result[:fex_result_get] || {}
      end

      def formatted_records
        return [] unless success?

        fex                 = Fex.new
        fex.id_cbte         = info[:id]
        fex.tipo_cbte       = info[:tipo_cbte]
        fex.punto_vta       = info[:punto_vta]
        fex.nro_cbte        = info[:cbte_nro]
        fex.fecha_cbte      = info[:fecha_cbte]
        fex.tipo_expo       = info[:tipo_expo]
        fex.tiene_permiso   = info[:permiso_existente]
        fex.pais            = info[:dst_cmp]
        fex.cuit_pais       = info[:cuit_pais_cliente]
        fex.id_impositivo   = info[:id_impositivo]
        fex.cliente         = info[:cliente]
        fex.domicilio       = info[:domicilio_cliente]
        fex.moneda          = info[:moneda_id]
        fex.cotizacion      = info[:moneda_ctz]
        fex.total           = info[:imp_total]
        fex.forma_pago      = info[:forma_pago]
        fex.idioma          = info[:idioma_cbte]
        fex.incoterms       = info[:incoterms]
        fex.incoterms_info  = info[:incoterms_ds]
        fex.cae             = info[:cae]
        fex.fecha_vto_cae   = info[:fch_venc_cae]
        fex.resultado       = info[:resultado]
        fex.obs             = info[:obs]
        fex.obs_comerciales = info[:obs_comerciales]

        info[:permisos][:permiso].each do |permiso|
          if permiso.has_key?(:id_permiso) &&
             permiso.has_key?(:dst_merc)

            fex.permisos << { :id_permiso => permiso[:id_permiso],
                              :dst_merc   => permiso[:dst_merc] }

          end
        end if info.has_key?(:permisos)

        info[:cmps_asoc][:cmp_asoc].each do |comprobante|
          if comprobante.has_key?(:cbte_tipo)      &&
             comprobante.has_key?(:cbte_punto_vta) &&
             comprobante.has_key?(:cbte_nro)

            fex.comprobantes << { :cbte_tipo      => comprobante[:cbte_tipo],
                                  :cbte_punto_vta => comprobante[:cbte_punto_vta],
                                  :cbte_nro       => comprobante[:cbte_nro] }
          end
        end if info.has_key?(:cmps_asoc)

        info[:items][:item].each do |item|
          if item.has_key?(:pro_codigo)     &&
             item.has_key?(:pro_ds)         &&
             item.has_key?(:pro_qty)        &&
             item.has_key?(:pro_umed)       &&
             item.has_key?(:pro_precio_uni) &&
             item.has_key?(:pro_total_item)

            fex.items << { :pro_codigo      => item[:pro_codigo],
                           :pro_ds          => item[:pro_ds],
                           :pro_qty         => item[:pro_qty],
                           :pro_umed        => item[:pro_umed],
                           :pro_precio_uni  => item[:pro_precio_uni],
                           :pro_total_item  => item[:pro_total_item] }
          end
        end if info.has_key?(:items)

        fex.to_s.split("\n")
      end
    end
  end
end
