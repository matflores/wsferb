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

    def self.checkPermiso(ticket, permiso, pais, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXCheck_Permiso(ticket_to_arg(ticket).merge({ :ID_Permiso => permiso.dup, :Dst_merc => pais.dup }))
      end
      return WSFEX::Response.new(response, :fEXCheck_PermisoResult, :status)
    end

    def self.getCmp(ticket, tipoCbte, puntoVta, nroCbte, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEXGetCMP(ticket_to_arg(ticket).merge({ :Cmp => { :Tipo_cbte => tipoCbte.dup, :Punto_vta => puntoVta.dup, :Cbte_nro => nroCbte.dup }}))
      end
      return WSFEX::Response.new(response, :fEXGetCMPResult, :cbte_nro, :fEXResult_LastCMP)
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
