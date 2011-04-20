#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "time"
require "wsaa"
require "savon"
require "config"

module WSFE

  class Client

    WSDL = File.join(File.dirname(__FILE__), '/wsfev1.wsdl')
    PROD_URL = 'https://servicios1.afip.gov.ar/wsfev1/service.asmx'
    TEST_URL = 'https://wswhomo.afip.gov.ar/wsfev1/service.asmx'

    @@test_mode_enabled = false

    def self.enable_test_mode
      @@test_mode_enabled = true
    end

    def self.disable_test_mode
      @@test_mode_enabled = false
    end

    def self.test_mode_enabled?
      @@test_mode_enabled
    end

    def self.fe_dummy
      response = client.request(:fe_dummy)
      "authserver=#{response.to_hash[:fe_dummy_response][:fe_dummy_result][:auth_server]}; appserver=#{response.to_hash[:fe_dummy_response][:fe_dummy_result][:app_server]}; dbserver=#{response.to_hash[:fe_dummy_response][:fe_dummy_result][:db_server]};"
    end

    def self.fe_comp_ultimo_autorizado(ticket, tipo_cbte, punto_vta)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_comp_ultimo_autorizado) do
        soap.body = ticket_to_arg(ticket).merge({ "CbteTipo" => tipo_cbte.dup, "PtoVta" => punto_vta.dup })
      end

      return Response::FECompUltimoAutorizado.new(response)
    end

    def self.fe_comp_tot_x_request(ticket)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_comp_tot_x_request) do
        soap.body = ticket_to_arg(ticket)
      end

      return Response::FECompTotXRequest.new(response)
    end

    def self.fe_param_get_tipos_cbte(ticket)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_param_get_tipos_cbte) do
        soap.body = ticket_to_arg(ticket)
      end

      return Response::FEParamGetTiposCbte.new(response)
    end

    def self.fe_param_get_tipos_concepto(ticket)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_param_get_tipos_concepto) do
        soap.body = ticket_to_arg(ticket)
      end

      return Response::FEParamGetTiposConcepto.new(response)
    end

    def self.fe_param_get_tipos_doc(ticket)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_param_get_tipos_doc) do
        soap.body = ticket_to_arg(ticket)
      end

      return Response::FEParamGetTiposDoc.new(response)
    end

    def self.fe_param_get_tipos_iva(ticket)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_param_get_tipos_iva) do
        soap.body = ticket_to_arg(ticket)
      end

      return Response::FEParamGetTiposIva.new(response)
    end

    def self.fe_param_get_tipos_moneda(ticket)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_param_get_tipos_moneda) do
        soap.body = ticket_to_arg(ticket)
      end

      return Response::FEParamGetTiposMoneda.new(response)
    end

    def self.fe_param_get_tipos_opcional(ticket)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_param_get_tipos_opcional) do
        soap.body = ticket_to_arg(ticket)
      end

      return Response::FEParamGetTiposOpcional.new(response)
    end

    def self.fe_param_get_tipos_tributos(ticket)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_param_get_tipos_tributos) do
        soap.body = ticket_to_arg(ticket)
      end

      return Response::FEParamGetTiposTributos.new(response)
    end

    def self.fe_param_get_ptos_venta(ticket)
      return ticket_missing if ticket.nil?

      response = client.request(:n1, :fe_param_get_ptos_venta) do
        soap.body = ticket_to_arg(ticket)
      end

      return Response::FEParamGetPtosVenta.new(response)
    end

    def self.ticket_missing
      Response.new(nil, :nil, nil)
    end

    def self.ticket_to_arg(ticket)
      return { :Auth => { :Token => ticket.token, :Sign => ticket.sign, :Cuit => ticket.cuit } }
    end

    def self.client
      @client ||= Savon::Client.new do |wsdl, http|
        wsdl.document = WSDL
        wsdl.endpoint = test_mode_enabled? ? TEST_URL : PROD_URL
      end
    end
  end
end
