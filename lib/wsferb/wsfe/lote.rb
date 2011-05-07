#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
module WSFErb
  module WSFE
    class Lote
       attr_accessor :tipo_cbte, :punto_vta, :fecha_proceso, :resultado, :comprobantes

       def initialize(tipo_cbte=nil, punto_vta=nil)
         @tipo_cbte = tipo_cbte
         @punto_vta = punto_vta
         @comprobantes = {}
       end

       def add(cbte)
         @comprobantes["#{cbte.nro_cbte_desde}:#{cbte.nro_cbte_hasta}"] = cbte
       end

       def get(nro_cbte_desde, nro_cbte_hasta)
         @comprobantes["#{nro_cbte_desde}:#{nro_cbte_hasta}"] ||= Cbte.new
       end

       def self.load(filename)
         new.tap do |lote|
           lines = File.readlines(filename)
           lines.each do |line|
             case line.split(//).first
             when "1"
               fields = line.strip.unpack("A1A4A3A4A14A1")

               lote.tipo_cbte     = fields[2].to_i
               lote.punto_vta     = fields[3].to_i
               lote.fecha_proceso = fields[4].to_s
               lote.resultado     = fields[5].to_s
             when "2"
               fields = line.strip.unpack("A1A8A8A2A2A11A8A15A15A15A15A15A15A8A8A8A3A10A14")

               nro_cbte_desde = fields[1].to_i
               nro_cbte_hasta = fields[2].to_i

               cbte = lote.get(nro_cbte_desde, nro_cbte_hasta)

               cbte.nro_cbte_desde   = nro_cbte_desde
               cbte.nro_cbte_hasta   = nro_cbte_hasta
               cbte.concepto         = fields[3].to_i
               cbte.tipo_doc         = fields[4].to_i
               cbte.nro_doc          = fields[5].to_i
               cbte.fecha_cbte       = fields[6]
               cbte.imp_total        = fields[7].to_i / 100.0
               cbte.imp_tot_conc     = fields[8].to_i / 100.0
               cbte.imp_neto         = fields[9].to_i / 100.0
               cbte.imp_op_ex        = fields[10].to_i / 100.0
               cbte.imp_iva          = fields[11].to_i / 100.0
               cbte.imp_trib         = fields[12].to_i / 100.0
               cbte.fecha_serv_desde = fields[13]
               cbte.fecha_serv_hasta = fields[14]
               cbte.fecha_vto        = fields[15]
               cbte.moneda           = fields[16]
               cbte.cotizacion       = fields[17].to_i / 1000000.0
               cbte.caea             = fields[18]
             when "3"
               fields = line.strip.unpack("A1A8A8A3A4A8")

               nro_cbte_desde = fields[1].to_i
               nro_cbte_hasta = fields[2].to_i

               cbte = lote.get(nro_cbte_desde, nro_cbte_hasta)

               cbte.comprobantes << { :Tipo   => fields[3].to_i,
                                      :PtoVta => fields[4].to_i,
                                      :Nro    => fields[5].to_i }
             when "4"
               fields = line.strip.unpack("A1A8A8A2A15A15")

               nro_cbte_desde = fields[1].to_i
               nro_cbte_hasta = fields[2].to_i

               cbte = lote.get(nro_cbte_desde, nro_cbte_hasta)

               cbte.iva << { :Id      => fields[3].to_i,
                             :BaseImp => fields[4].to_i / 100.0,
                             :Importe => fields[5].to_i / 100.0 }
             when "5"
               fields = line.strip.unpack("A1A8A8A2A15A5A15A80")

               nro_cbte_desde = fields[1].to_i
               nro_cbte_hasta = fields[2].to_i

               cbte = lote.get(nro_cbte_desde, nro_cbte_hasta)

               cbte.tributos << { :Id      => fields[3].to_i,
                                  :BaseImp => fields[4].to_i / 100.0,
                                  :Alic    => fields[5].to_i / 100.0,
                                  :Importe => fields[6].to_i / 100.0,
                                  :Desc    => fields[7] }
             when "6"
               fields = line.strip.unpack("A1A8A8A2A100")

               nro_cbte_desde = fields[1].to_i
               nro_cbte_hasta = fields[2].to_i

               cbte = lote.get(nro_cbte_desde, nro_cbte_hasta)

               cbte.opcionales << { :Id    => fields[3].to_i,
                                    :Valor => fields[4] }
             when "C"
               fields = line.strip.unpack("A1A8A8A1A4A14A8")

               nro_cbte_desde = fields[1].to_i
               nro_cbte_hasta = fields[2].to_i

               cbte = lote.get(nro_cbte_desde, nro_cbte_hasta)

               cbte.resultado     = fields[3]
               cbte.tipo_cae      = fields[4]
               cbte.cae           = fields[5]
               cbte.fecha_vto_cae = fields[6]
             when "O"
               fields = line.strip.unpack("A1A8A8A6A512")

               nro_cbte_desde = fields[1].to_i
               nro_cbte_hasta = fields[2].to_i

               cbte = lote.get(nro_cbte_desde, nro_cbte_hasta)

               cbte.observaciones << { :Code => fields[3].to_i,
                                       :Msg  => fields[4] }
             end
           end
         end
       end
 
       def self.from_hash(hash, header_key = :fe_cab_resp, items_key = :fe_det_resp, item_key = :fecae_det_response)
         new.tap do |lote|
           lote.tipo_cbte     = hash[header_key][:cbte_tipo]   rescue 0
           lote.punto_vta     = hash[header_key][:pto_vta]     rescue 0
           lote.fecha_proceso = hash[header_key][:fch_proceso] rescue ""
           lote.resultado     = hash[header_key][:resultado]   rescue ""

           [hash[items_key][item_key]].flatten.each do |hash_cbte|
             lote.add(Cbte.from_hash(hash_cbte))
           end rescue nil
         end
       end

       def save(filename)
         File.open(filename, "w") do |file|
           file.write to_s
         end
       end
 
       def to_hash(header_key = :FeCabReq, items_key = :FeDetReq, item_key = :FECAEDetRequest)
         cbte_data = {
           header_key => {
             :CantReg  => comprobantes.size,
             :CbteTipo => tipo_cbte,
             :PtoVta   => punto_vta
           },
           items_key => {
             item_key => comprobantes.values.map(&:to_hash)
           }
         }
       end
 
       def to_s
         lines = []
 
         formato = "1%04d%03d%04d%-14s%1s"
         lines << (formato % [ comprobantes.size,
                               tipo_cbte.to_i,
                               punto_vta.to_i,
                               fecha_proceso.to_s,
                               resultado.to_s ]).strip

         comprobantes.each do |key, cbte|
           lines << cbte.to_s
         end

         lines.join("\n")
       end
     end
  end
end
