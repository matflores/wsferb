#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'time'
require 'soap/wsdlDriver'
require 'wsaa'

module WSFEX

  class Client < AFIP::Client

    WSDL = File.dirname(__FILE__) + '/wsfex.wsdl'
    PROD_URL = 'https://servicios1.afip.gov.ar/wsfex/service.asmx'
    TEST_URL = 'https://wswhomo.afip.gov.ar/wsfex/service.asmx'

    def self.authorize(ticket, entrada, salida, log_file=nil)
      return ticket_missing if ticket.nil?

      fex = WSFEX::Fex.from_file(entrada)
      response = with_driver(:log => log_file) do |driver|
        driver.fEXAuthorize(ticket_to_arg(ticket).merge({ :Cmp => fex.to_hash.dup }))
      end

      errCode = response.fEXAuthorizeResult.fEXErr.errCode.to_i rescue -1

      if errCode == 0 && response.respond_to?(:fEXAuthorizeResult) && response.fEXAuthorizeResult.respond_to?(:fEXResultAuth)
        result = response.fEXAuthorizeResult.fEXResultAuth

        fex.cae             = result.cae
        fex.fecha_cae       = result.fch_cbte
        fex.fecha_vto_cae   = result.fch_venc_Cae
        fex.resultado       = result.resultado

        fex.to_file(salida)
      end

      return WSFEX::Response.new(response, :fEXAuthorizeResult, :cae, :fEXResultAuth)
    end

    def self.checkPermiso(ticket, permiso, pais, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXCheck_Permiso(ticket_to_arg(ticket).merge({ :ID_Permiso => permiso.dup, :Dst_merc => pais.dup }))
      end
      return WSFEX::Response.new(response, :fEXCheck_PermisoResult, :status)
    end

    def self.getCmp(ticket, tipoCbte, puntoVta, nroCbte, salida, log_file=nil)
      return ticket_missing if ticket.nil?

      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetCMP(ticket_to_arg(ticket).merge({ :Cmp => { :Tipo_cbte => tipoCbte.dup, :Punto_vta => puntoVta.dup, :Cbte_nro => nroCbte.dup }}))
      end

      errCode = response.fEXGetCMPResult.fEXErr.errCode.to_i rescue -1

      if errCode == 0 && response.respond_to?(:fEXGetCMPResult) && response.fEXGetCMPResult.respond_to?(:fEXResultGet)
        result = response.fEXGetCMPResult.fEXResultGet

        fex                 = WSFEX::Fex.new

        fex.id_cbte         = result.id
        fex.tipo_cbte       = result.tipo_cbte
        fex.punto_vta       = result.punto_vta
        fex.nro_cbte        = result.cbte_nro
        fex.fecha_cbte      = result.fecha_cbte
        fex.tipo_expo       = result.tipo_expo
        fex.tiene_permiso   = result.permiso_existente
        fex.pais            = result.dst_cmp
        fex.cuit_pais       = result.cuit_pais_cliente
        fex.id_impositivo   = result.id_impositivo
        fex.cliente         = result.cliente
        fex.domicilio       = result.domicilio_cliente
        fex.moneda          = result.moneda_Id
        fex.cotizacion      = result.moneda_ctz
        fex.total           = result.imp_total
        fex.forma_pago      = result.forma_pago
        fex.idioma          = result.idioma_cbte
        fex.incoterms       = result.incoterms
        fex.incoterms_info  = result.incoterms_Ds
        fex.cae             = result.cae
        fex.fecha_cae       = result.fecha_cbte
        fex.fecha_vto_cae   = result.fch_venc_Cae
        fex.resultado       = result.resultado
        fex.obs             = result.obs
        fex.obs_comerciales = result.obs_comerciales

        result.permisos.permiso.each do |permiso|
          if permiso.respond_to?(:id_permiso) &&
             permiso.respond_to?(:dst_merc)

            fex.permisos << { :Id_permiso => permiso.id_permiso,
                              :Dst_merc   => permiso.dst_merc }

          end
        end if result.respond_to?(:permisos)

        result.cmps_asoc.cmp_asoc.each do |comprobante|
          if comprobante.respond_to?(:cbte_tipo)      &&
             comprobante.respond_to?(:cbte_punto_vta) &&
             comprobante.respond_to?(:cbte_nro)

            fex.comprobantes << { :Cbte_tipo      => comprobante.cbte_tipo,
                                  :Cbte_punto_vta => comprobante.cbte_punto_vta,
                                  :Cbte_nro       => comprobante.cbte_nro }
          end
        end if result.respond_to?(:cmps_asoc)

        result.items.item.each do |item|
          if item.respond_to?(:pro_codigo)     &&
             item.respond_to?(:pro_ds)         &&
             item.respond_to?(:pro_qty)        &&
             item.respond_to?(:pro_umed)       &&
             item.respond_to?(:pro_precio_uni) &&
             item.respond_to?(:pro_total_item)

            fex.items << { :Pro_codigo      => item.pro_codigo,
                           :Pro_ds          => item.pro_ds,
                           :Pro_qty         => item.pro_qty,
                           :Pro_umed        => item.pro_umed,
                           :Pro_precio_uni  => item.pro_precio_uni,
                           :Pro_total_item  => item.pro_total_item }
          end
        end if result.respond_to?(:items)

        fex.to_file(salida)
      end

      return WSFEX::Response.new(response, :fEXGetCMPResult, :cae)
    end

    def self.getLastCmp(ticket, tipoCbte, puntoVta, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|

        args = { :Auth => { :Token     => ticket.token.dup,
                            :Sign      => ticket.sign.dup,
                            :Cuit      => ticket.cuit.dup,
                            :Pto_venta => puntoVta.dup,
                            :Tipo_cbte => tipoCbte.dup } }

        driver.fEXGetLast_CMP(args)
      end
      return WSFEX::Response.new(response, :fEXGetLast_CMPResult, :cbte_nro, :fEXResult_LastCMP)
    end

    def self.getLastId(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetLast_ID(ticket_to_arg(ticket))
      end
      return WSFEX::Response.new(response, :fEXGetLast_IDResult, :id)
    end

    def self.getParamCtz(ticket, moneda, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_Ctz(ticket_to_arg(ticket).merge({ :Mon_id => moneda }))
      end
      return WSFEX::Response.new(response, :fEXGetPARAM_CtzResult, :mon_ctz)
    end

    def self.getParamDstCuit(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_DST_CUIT(ticket_to_arg(ticket))
      end
      return WSFEX::Response::GetParamDstCuit.new(response, :fEXGetPARAM_DST_CUITResult, :nil)
    end

    def self.getParamDstPais(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_DST_pais(ticket_to_arg(ticket))
      end
      return WSFEX::Response::GetParamDstPais.new(response, :fEXGetPARAM_DST_paisResult, :nil)
    end

    def self.getParamIdiomas(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_Idiomas(ticket_to_arg(ticket))
      end
      return WSFEX::Response::GetParamIdiomas.new(response, :fEXGetPARAM_IdiomasResult, :nil)
    end

    def self.getParamIncoterms(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_Incoterms(ticket_to_arg(ticket))
      end
      return WSFEX::Response::GetParamIncoterms.new(response, :fEXGetPARAM_IncotermsResult, :nil)
    end

    def self.getParamMon(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_MON(ticket_to_arg(ticket))
      end
      return WSFEX::Response::GetParamMon.new(response, :fEXGetPARAM_MONResult, :nil)
    end

    def self.getParamPtoVenta(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_PtoVenta(ticket_to_arg(ticket))
      end
      return WSFEX::Response::GetParamPtoVenta.new(response, :fEXGetPARAM_PtoVentaResult, :nil)
    end

    def self.getParamTipoCbte(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_Tipo_Cbte(ticket_to_arg(ticket))
      end
      return WSFEX::Response::GetParamTipoCbte.new(response, :fEXGetPARAM_Tipo_CbteResult, :nil)
    end

    def self.getParamTipoExpo(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_Tipo_Expo(ticket_to_arg(ticket))
      end
      return WSFEX::Response::GetParamTipoExpo.new(response, :fEXGetPARAM_Tipo_ExpoResult, :nil)
    end

    def self.getParamUMed(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetPARAM_UMed(ticket_to_arg(ticket))
      end
      return WSFEX::Response::GetParamUMed.new(response, :fEXGetPARAM_UMedResult, :nil)
    end

    def self.test(log_file=nil)
      response = with_driver(:log => log_file) do |driver|
        driver.fEXDummy(nil)
      end
      "authserver=#{response.fEXDummyResult.authServer}; appserver=#{response.fEXDummyResult.appServer}; dbserver=#{response.fEXDummyResult.dbServer};"
    end

    def self.ticket_missing
      WSFEX::Response.new(nil, :nil, nil)
    end

    def self.ticket_to_arg(ticket)
      return { :Auth => { :Token => ticket.token, :Sign => ticket.sign, :Cuit => ticket.cuit } }
    end
  end

end
