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
           cbte.nro_cbte_desde   = hash[:Cbte_desde]
           cbte.nro_cbte_hasta   = hash[:Cbte_hasta]
           cbte.concepto         = hash[:Concepto]
           cbte.tipo_doc         = hash[:Doc_tipo]
           cbte.nro_doc          = hash[:Doc_nro]
           cbte.fecha_cbte       = hash[:Cbte_fch]
           cbte.imp_total        = hash[:Imp_total]
           cbte.imp_tot_conc     = hash[:Imp_tot_conc]
           cbte.imp_neto         = hash[:Imp_neto]
           cbte.imp_op_ex        = hash[:Imp_op_ex]
           cbte.imp_iva          = hash[:Imp_iva]
           cbte.imp_trib         = hash[:Imp_trib]
           cbte.fecha_serv_desde = hash[:Fch_serv_desde]
           cbte.fecha_serv_hasta = hash[:Fch_serv_hasta]
           cbte.fecha_vto        = hash[:Fch_vto_pago]
           cbte.moneda           = hash[:Mon_id]
           cbte.cotizacion       = hash[:Mon_cotiz]
           cbte.caea             = hash[:Caea]

           cbte.comprobantes     = [hash[:Cbtes_asoc][:Cbte_asoc]].flatten if hash.has_key?(:Cbtes_asoc)
           cbte.iva              = [hash[:Iva][:Alic_iva]].flatten if hash.has_key?(:Iva)
           cbte.tributos         = [hash[:Tributos][:Tributo]].flatten if hash.has_key?(:Tributos)
           cbte.opcionales       = [hash[:Opcionales][:Opcional]].flatten if hash.has_key?(:Opcionales)
           cbte.observaciones    = [hash[:Obs][:Observaciones]].flatten if hash.has_key?(:Obs)
         end
       end

       def to_hash
         cbte_data = { :Cbte_desde     => nro_cbte_desde,
                       :Cbte_hasta     => nro_cbte_hasta,
                       :Concepto       => concepto,
                       :Doc_tipo       => tipo_doc,
                       :Doc_nro        => nro_doc,
                       :Cbte_fch       => fecha_cbte,
                       :Imp_total      => imp_total,
                       :Imp_tot_conc   => imp_tot_conc,
                       :Imp_neto       => imp_neto,
                       :Imp_op_ex      => imp_op_ex,
                       :Imp_iva        => imp_iva,
                       :Imp_trib       => imp_trib,
                       :Fch_serv_desde => fecha_serv_desde,
                       :Fch_serv_hasta => fecha_serv_hasta,
                       :Fch_vto_pago   => fecha_vto,
                       :Mon_id         => moneda,
                       :Mon_cotiz      => cotizacion,
                       :Caea           => caea
                     }

         cbte_data.merge!({ :Cae => cae, :Cae_fch_vto => fecha_vto_cae, :Resultado => resultado }) unless cae.to_s.empty?
         cbte_data.merge!({ :Cbtes_asoc => { :Cbte_asoc => comprobantes }}) unless comprobantes.empty?
         cbte_data.merge!({ :Iva        => { :Alic_iva => iva }}) unless iva.empty?
         cbte_data.merge!({ :Tributos   => { :Tributo => tributos }}) unless tributos.empty?
         cbte_data.merge!({ :Opcionales => { :Opcional => opcionales }}) unless opcionales.empty?
         cbte_data.merge!({ :Obs        => { :Observaciones => observaciones }}) unless observaciones.empty?

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
                                 comprobante[:Tipo].to_i,
                                 comprobante[:Pto_vta].to_i,
                                 comprobante[:Nro].to_i ]).strip
         end

         formato = "4%08d%08d%02d%015d%015d"
         iva.each do |iva|
           lines << (formato % [ nro_cbte_desde.to_i,
                                 nro_cbte_hasta.to_i,
                                 iva[:Id].to_i,
                                 (iva[:Base_imp].to_f * 100),
                                 (iva[:Importe].to_f * 100) ]).strip
         end

         formato = "5%08d%08d%02d%015d%05d%015d%-80s"
         tributos.each do |tributo|
           lines << (formato % [ nro_cbte_desde.to_i,
                                 nro_cbte_hasta.to_i,
                                 tributo[:Id].to_i,
                                 (tributo[:Base_imp].to_f * 100),
                                 (tributo[:Alic].to_f * 100),
                                 (tributo[:Importe].to_f * 100),
                                 tributo[:Desc] ]).strip
         end

         formato = "6%08d%08d%02d%-100s"
         opcionales.each do |opcional|
           lines << (formato % [ nro_cbte_desde.to_i,
                                 nro_cbte_hasta.to_i,
                                 opcional[:Id].to_i,
                                 opcional[:Valor].to_s ]).strip
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
                                 obs[:Code].to_i,
                                 obs[:Msg].to_s ]).strip
         end
 
         lines.join("\n")
       end
     end
  end
end
