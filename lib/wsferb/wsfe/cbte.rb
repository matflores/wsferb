#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Cbte
       attr_accessor :nro_cbte_desde, :nro_cbte_hasta, :concepto, :tipo_doc, :nro_doc,
                     :fecha_cbte, :fecha_serv_desde, :fecha_serv_hasta, :fecha_vto,
                     :imp_total, :imp_tot_conc, :imp_neto, :imp_op_ex, :imp_iva, :imp_trib,
                     :moneda, :cotizacion, :caea, :cae, :tipo_cae, :fecha_vto_cae, :resultado,
                     :comprobantes, :iva, :tributos, :opcionales, :observaciones

       def initialize
         @comprobantes  = []
         @iva           = []
         @tributos      = []
         @opcionales    = []
         @observaciones = []
       end
 
       def self.from_hash(hash)
         new.tap do |cbte|
           cbte.nro_cbte_desde   = hash[:cbte_desde]
           cbte.nro_cbte_hasta   = hash[:cbte_hasta]
           cbte.concepto         = hash[:concepto]
           cbte.tipo_doc         = hash[:doc_tipo]
           cbte.nro_doc          = hash[:doc_nro]
           cbte.fecha_cbte       = hash[:cbte_fch]
           cbte.imp_total        = hash[:imp_total]
           cbte.imp_tot_conc     = hash[:imp_tot_conc]
           cbte.imp_neto         = hash[:imp_neto]
           cbte.imp_op_ex        = hash[:imp_op_ex]
           cbte.imp_iva          = hash[:imp_iva]
           cbte.imp_trib         = hash[:imp_trib]
           cbte.fecha_serv_desde = hash[:fch_serv_desde]
           cbte.fecha_serv_hasta = hash[:fch_serv_hasta]
           cbte.fecha_vto        = hash[:fch_vto_pago]
           cbte.moneda           = hash[:mon_id]
           cbte.cotizacion       = hash[:mon_cotiz]
           cbte.caea             = hash[:caea]
           cbte.cae              = hash[:cae]
           cbte.fecha_vto_cae    = hash[:cae_fch_vto]
           cbte.resultado        = hash[:resultado]

           cbte.comprobantes     = [hash[:cbtes_asoc][:cbte_asoc]].flatten if hash.has_key?(:cbtes_asoc)
           cbte.iva              = [hash[:iva][:alic_iva]].flatten if hash.has_key?(:iva)
           cbte.tributos         = [hash[:tributos][:tributo]].flatten if hash.has_key?(:tributos)
           cbte.opcionales       = [hash[:opcionales][:opcional]].flatten if hash.has_key?(:opcionales)
           cbte.observaciones    = [hash[:observaciones][:obs]].flatten if hash.has_key?(:observaciones)
         end
       end

       def to_hash
         cbte_data = { :CbteDesde    => nro_cbte_desde,
                       :CbteHasta    => nro_cbte_hasta,
                       :Concepto     => concepto,
                       :DocTipo      => tipo_doc,
                       :DocNro       => nro_doc,
                       :CbteFch      => fecha_cbte,
                       :ImpTotal     => imp_total,
                       :ImpTotConc   => imp_tot_conc,
                       :ImpNeto      => imp_neto,
                       :ImpOpEx      => imp_op_ex,
                       :ImpIVA       => imp_iva,
                       :ImpTrib      => imp_trib,
                       :FchServDesde => fecha_serv_desde,
                       :FchServHasta => fecha_serv_hasta,
                       :FchVtoPago   => fecha_vto,
                       :MonId        => moneda,
                       :MonCotiz     => cotizacion,
                       :Caea         => caea
                     }

         cbte_data.merge!({ :Cae           => cae, :CaeFchVto => fecha_vto_cae, :Resultado => resultado }) unless cae.to_s.empty?
         cbte_data.merge!({ :CbtesAsoc     => { :CbteAsoc => comprobantes }}) unless comprobantes.empty?
         cbte_data.merge!({ :Iva           => { :AlicIva => iva }}) unless iva.empty?
         cbte_data.merge!({ :Tributos      => { :Tributo => tributos }}) unless tributos.empty?
         cbte_data.merge!({ :Opcionales    => { :Opcional => opcionales }}) unless opcionales.empty?
         cbte_data.merge!({ :Observaciones => { :Obs => observaciones }}) unless observaciones.empty?

         cbte_data
       end
 
       def to_s
         lines = []
 
         formato = "2%08d%08d%02d%02d%011d%-8s%015d%015d%015d%015d%015d%015d%-8s%-8s%-8s%-3s%010d%-14s"
         lines << (formato % [ nro_cbte_desde.to_i,
                               nro_cbte_hasta.to_i,
                               concepto.to_i,
                               tipo_doc.to_i,
                               nro_doc.to_i,
                               fecha_cbte.to_s,
                               (imp_total.to_f * 100),
                               (imp_tot_conc.to_f * 100),
                               (imp_neto.to_f * 100),
                               (imp_op_ex.to_f * 100),
                               (imp_iva.to_f * 100),
                               (imp_trib.to_f * 100),
                               fecha_serv_desde.to_s,
                               fecha_serv_hasta.to_s,
                               fecha_vto.to_s,
                               moneda.to_s,
                               (cotizacion.to_f * 1000000),
                               caea.to_s ]).strip

         formato = "3%08d%08d%03d%04d%08d"
         comprobantes.each do |comprobante|
           lines << (formato % [ nro_cbte_desde.to_i,
                                 nro_cbte_hasta.to_i,
                                 (comprobante[:Tipo] || comprobante[:tipo]).to_i,
                                 (comprobante[:PtoVta] || comprobante[:pto_vta]).to_i,
                                 (comprobante[:Nro] || comprobante[:nro]).to_i ]).strip
         end

         formato = "4%08d%08d%02d%015d%015d"
         iva.each do |iva|
           lines << (formato % [ nro_cbte_desde.to_i,
                                 nro_cbte_hasta.to_i,
                                 (iva[:Id] || iva[:id]).to_i,
                                 ((iva[:BaseImp] || iva[:base_imp]).to_f * 100),
                                 ((iva[:Importe] || iva[:importe]).to_f * 100) ]).strip
         end

         formato = "5%08d%08d%02d%015d%05d%015d%-80s"
         tributos.each do |tributo|
           lines << (formato % [ nro_cbte_desde.to_i,
                                 nro_cbte_hasta.to_i,
                                 (tributo[:Id] || tributo[:id]).to_i,
                                 ((tributo[:BaseImp] || tributo[:base_imp]).to_f * 100),
                                 ((tributo[:Alic] || tributo[:alic]).to_f * 100),
                                 ((tributo[:Importe] || tributo[:importe]).to_f * 100),
                                 (tributo[:Desc] || tributo[:desc]).to_s ]).strip
         end

         formato = "6%08d%08d%02d%-100s"
         opcionales.each do |opcional|
           lines << (formato % [ nro_cbte_desde.to_i,
                                 nro_cbte_hasta.to_i,
                                 (opcional[:Id] || opcional[:id]).to_i,
                                 (opcional[:Valor] || opcional[:valor]).to_s ]).strip
         end

         unless cae.to_s.empty? 
           formato = "C%08d%08d%1s%-4s%-14s%-8s"
           lines << (formato % [ nro_cbte_desde.to_i,
                                 nro_cbte_hasta.to_i,
                                 resultado.to_s,
                                 tipo_cae.to_s,
                                 cae.to_s,
                                 fecha_vto_cae.to_s ]).strip
         end
 
         formato = "O%08d%08d%06d%-512s"
         observaciones.each do |obs|
           lines << (formato % [ nro_cbte_desde.to_i,
                                 nro_cbte_hasta.to_i,
                                 (obs[:Code] || obs[:code]).to_i,
                                 (obs[:Msg] || obs[:msg]).to_s ]).strip
         end
 
         lines.join("\n")
       end
     end
  end
end
