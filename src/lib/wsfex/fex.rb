#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#

module WSFEX
  class Fex
    attr_accessor :id_cbte, :tipo_cbte, :nro_cbte, :punto_vta, :fecha_cbte, :tipo_expo, :tiene_permiso,
                  :pais, :cuit_pais, :id_impositivo, :cliente, :domicilio, :moneda, :cotizacion, :total,
                  :forma_pago, :idioma, :incoterms, :incoterms_info, :obs, :obs_comerciales,
                  :cae, :fecha_cae, :fecha_vto_cae, :resultado, :motivos, :permisos, :comprobantes, :items

    def initialize
      permisos     = []
      comprobantes = []
      items        = []
    end

    def self.from_file(filename)
      new.tap do |fex|
        lines = File.readlines(filename)
        lines.each do |line|
          fields = line.unpack('A1A15A2A4A8A8A1A1A3A11A50A200A300A3A11A15A50A1A3A20A14A8A8A1A40A1000A1000')
          if fields[0] == '1'
            fex.id_cbte          = fields[1].to_i
            fex.tipo_cbte        = fields[2].to_i
            fex.punto_vta        = fields[3].to_i
            fex.nro_cbte         = fields[4].to_i
            fex.fecha_cbte       = fields[5]
            fex.tipo_expo        = fields[6].to_i
            fex.tiene_permiso    = fields[7]
            fex.pais             = fields[8].to_i
            fex.cuit_pais        = fields[9].to_i
            fex.id_impositivo    = fields[10]
            fex.cliente          = fields[11]
            fex.domicilio        = fields[12]
            fex.moneda           = fields[13]
            fex.cotizacion       = fields[14].to_i / 1000000.0
            fex.total            = fields[15].to_i / 100.0
            fex.forma_pago       = fields[16]
            fex.idioma           = fields[17].to_i
            fex.incoterms        = fields[18]
            fex.incoterms_info   = fields[19]
            fex.cae              = fields[20]
            fex.fecha_cae        = fields[21]
            fex.fecha_vto_cae    = fields[22]
            fex.resultado        = fields[23]
            fex.motivos          = fields[24]
            fex.obs              = fields[25]
            fex.obs_comerciales  = fields[26]
          end
        end
      end
    end

    def self.from_hash(hash)
      new.tap do |fex|
        fex.id_cbte          = hash[:Id]
        fex.tipo_cbte        = hash[:Tipo_cbte]
        fex.punto_vta        = hash[:Punto_vta]
        fex.nro_cbte         = hash[:Cbte_nro]
        fex.fecha_cbte       = hash[:Fecha_cbte]
        fex.tipo_expo        = hash[:Tipo_expo]
        fex.tiene_permiso    = hash[:Permiso_existente]
        fex.pais             = hash[:Dst_cmp]
        fex.cuit_pais        = hash[:Cuit_pais_cliente]
        fex.id_impositivo    = hash[:Id_impositivo]
        fex.cliente          = hash[:Cliente]
        fex.domicilio        = hash[:Domicilio_cliente]
        fex.moneda           = hash[:Moneda_Id]
        fex.cotizacion       = hash[:Moneda_ctz]
        fex.total            = hash[:Imp_total]
        fex.forma_pago       = hash[:Forma_pago]
        fex.idioma           = hash[:Idioma_cbte]
        fex.incoterms        = hash[:Incoterms]
        fex.incoterms_info   = hash[:Incoterms_Ds]
        fex.cae              = hash[:Cae]
        fex.fecha_cae        = hash[:Fecha_cbte_cae]
        fex.fecha_vto_cae    = hash[:Fecha_venc_cae]
        fex.resultado        = hash[:Resultado]
        fex.motivos          = hash[:Motivos_Obs]
        fex.obs              = hash[:Obs]
        fex.obs_comerciales  = hash[:Obs_comerciales]
      end
    end

    def to_file(filename)
      File.open(filename, 'w') do |file|
        formato = "1%015d%02d%04d%08d%-8s%1s%1s%03d%011d%-50s%-200s%-300s%3s%011d%015d%-50s%1s%-3s%-20s%-14s%-8s%-8s%1s%-40s%-1000s%-1000s\n"
        file.write formato % [ id_cbte, tipo_cbte, punto_vta, nro_cbte, fecha_cbte, tipo_expo, tiene_permiso,
                               pais, cuit_pais, id_impositivo, cliente, domicilio, moneda,
                               (cotizacion.to_f*1000000), (total.to_f*100), forma_pago, idioma, incoterms, 
                               incoterms_info, cae, fecha_cae, fecha_vto_cae, resultado, motivos, obs, obs_comerciales ]
      end
    end

    def to_hash(include_cae = true)
      cbte_data = { :Id                => id_cbte,
                    :Tipo_cbte         => tipo_cbte,
                    :Punto_vta         => punto_vta,
                    :Cbte_nro          => nro_cbte,
                    :Fecha_cbte        => fecha_cbte,
                    :Tipo_expo         => tipo_expo,
                    :Permiso_existente => tiene_permiso,
                    :Dst_cmp           => pais,
                    :Cuit_pais_cliente => cuit_pais,
                    :Id_impositivo     => id_impositivo,
                    :Cliente           => cliente,
                    :Domicilio_cliente => domicilio,
                    :Moneda_Id         => moneda,
                    :Moneda_ctz        => cotizacion,
                    :Imp_total         => total,
                    :Forma_pago        => forma_pago,
                    :Idioma_cbte       => idioma,
                    :Incoterms         => incoterms,
                    :Incoterms_Ds      => incoterms_info,
                    :Obs               => obs,
                    :Obs_comerciales   => obs_comerciales
                  }

      cae_data =  { :Cae               => cae,
                    :Fecha_cbte_cae    => fecha_cae,
                    :Fecha_venc_cae    => fecha_vto_cae,
                    :Resultado         => resultado,
                    :Motivos_Obs       => motivos
                  }

      include_cae ? cbte_data.merge(cae_data) : cbte_data
    end
  end
end
