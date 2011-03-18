#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2011 Matias Alejandro Flores <mflores@atlanware.com>
#
require "time"
require "wsaa"
require "savon"
require "config"

module WSFE

  class Client < AFIP::Client

    WSDL = File.join(File.dirname(__FILE__), '/wsfev1.wsdl')
    PROD_URL = 'https://servicios1.afip.gov.ar/wsfev1/service.asmx'
    TEST_URL = 'https://wswhomo.afip.gov.ar/wsfev1/service.asmx'

    def self.factura_lote(ticket, id, cuit, esServicios, lote, salida=nil, log_file=nil)
      return ticket_missing if ticket.nil?
      items = read_items_from_file(cuit, esServicios, lote)
      r = self.factura_items(ticket, id, esServicios, items, log_file)
      unless salida.nil?
        out = File.open(salida, 'w')
        if r.respond_to?(:fEAutRequestResult) && r.fEAutRequestResult.respond_to?(:fecResp) && r.fEAutRequestResult.respond_to?(:fedResp) && r.fEAutRequestResult.fedResp.respond_to?(:fEDetalleResponse)
          c = r.fEAutRequestResult.fecResp
          out.write "1%011d00%08d00000133972%015d01360400%05d%1s%-2s%1d\n" % [ c.cuit, c.fecha_cae, id, c.cantidadreg, c.resultado, c.motivo, c.presta_serv]
          r.fEAutRequestResult.fedResp.fEDetalleResponse.to_a.each do |d|
            if d.resultado == 'A'
              formato = "2%08d%02d%04d%08d%08d%02d%011d%015d%015d%015d%015d%015d%015dA%-14s%-8s%-8s%08d%08d%08d\n" 
            else
              formato = "4%08d%02d%04d%08d%08d%02d%011d%015d%015d%015d%015d%015d%015dR%-14s%-8s%-11s%08d%08d%08d\n" 
            end
            out.write formato % [ d.fecha_cbte, d.tipo_cbte, d.punto_vta, d.cbt_desde, d.cbt_hasta, d.tipo_doc, d.nro_doc, 
                                  (d.imp_total.to_f*100).to_i, (d.imp_tot_conc.to_f*100).to_i, (d.imp_neto.to_f*100).to_i, (d.impto_liq.to_f*100).to_i, (d.impto_liq_rni.to_f*100).to_i, (d.imp_op_ex.to_f*100).to_i,
                                  d.cae, d.fecha_vto, d.motivo, d.fecha_serv_desde, d.fecha_serv_hasta, d.fecha_venc_pago ]
          end
        end
        out.close
      end
      return WSFE::Response.new(r, :fEAutRequestResult, id)
    end

    def self.factura_items(ticket, id, esServicios, items, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        cabecera = { :id => id, :cantidadreg => items.size, :presta_serv => (esServicios ? 1 : 0)}
        detalle = { :FEDetalleRequest => items } 
        driver.fEAutRequest(ticket_to_arg(ticket).merge({ :Fer => { :Fecr => cabecera, :Fedr => detalle }}))
      end
      return response
    end

    def self.recuperaMaxQty(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fERecuperaQTYRequest(ticket_to_arg(ticket))
      end
      return WSFE::Response.new(response, :fERecuperaQTYRequestResult, :qty)
    end

    def self.recuperaUltNroTransaccion(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEUltNroRequest(ticket_to_arg(ticket))
      end
      return WSFE::Response.new(response, :fEUltNroRequestResult, :nro)
    end

    def self.recuperaUltNroCbte(ticket, puntoVta, tipoCbte, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fERecuperaLastCMPRequest(ticket_to_arg(ticket).merge({ :argTCMP => { :PtoVta => puntoVta.dup, :TipoCbte => tipoCbte.dup }}))
      end
      return WSFE::Response.new(response, :fERecuperaLastCMPRequestResult, :cbte_nro)
    end

    def self.test(log_file=nil)
      response = with_driver(:log => log_file) do |driver|
        driver.fEDummy(nil)
      end
      "authserver=#{response.fEDummyResult.authserver}; appserver=#{response.fEDummyResult.appserver}; dbserver=#{response.fEDummyResult.dbserver};"
    end

    def self.verificaCAE(ticket, cae, cuit, puntoVta, tipoCbte, nroCbte, importe, fecha, log_file=nil)
      return ticket_missing if ticket.nil?
      response = with_driver(:log => log_file) do |driver|
        driver.fEConsultaCAERequest(ticket_to_arg(ticket).merge({ :argCAERequest => { :cuit_emisor => cuit.dup, :tipo_cbte => tipoCbte.dup, :punto_vta => puntoVta.dup, :cbt_nro => nroCbte.dup, :imp_total => importe.dup, :cae => cae.dup, :fecha_cbte => fecha.dup }}))
      end
      return WSFE::Response.new(response, :fEConsultaCAERequestResult, :resultado)
    end

    def self.read_items_from_file(cuit, esServicios, lote)
      items = []
      lines = File.readlines(lote)
      lines.each do |line|
        fields = line.unpack('A1A8A2A1A4A8A8A3A2A11A30A15A15A15A15A15A15A15A15A15A15A8A8A8A6A1A1A14A8A8')
        unless esServicios
	        hoy = Time.now
	        vto = Time.local(hoy.year, hoy.month == 12 ? 1 : hoy.month + 1, hoy.day)
          fields[21] = fields[22] = hoy.strftime("%Y%m%d")
          fields[23] = vto.strftime("%Y%m%d")
        end
        items << {
                   :tipo_doc         => fields[8],
                   :nro_doc          => fields[9],
                   :tipo_cbte        => fields[02],
                   :punto_vta        => fields[4],
                   :cbt_desde        => fields[5],
                   :cbt_hasta        => fields[6],
                   :imp_total        => fields[11].to_i / 100.0,
                   :imp_tot_conc     => fields[12].to_i / 100.0,
                   :imp_neto         => fields[13].to_i / 100.0,
                   :impto_liq        => fields[14].to_i / 100.0,
                   :impto_liq_rni    => fields[15].to_i / 100.0,
                   :imp_op_ex        => fields[16].to_i / 100.0,
                   :fecha_cbte       => fields[1],
                   :fecha_serv_desde => fields[21],
                   :fecha_serv_hasta => fields[22],
                   :fecha_venc_pago  => fields[23]
                 } if fields[0] == '1'
      end
      items
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
