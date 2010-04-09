#
# Web Services Facturacion Electronica AFIP
# Copyright (C) 2008-2010 Matias Alejandro Flores <mflores@atlanware.com>
#
require 'time'
require 'soap/wsdlDriver'
require 'wsaa'

module WSFE

  class Client < AFIP::Client

    WSDL = File.dirname(__FILE__) + '/wsfe.wsdl'
    PROD_URL = 'https://servicios1.afip.gov.ar/wsfe/service.asmx'
    TEST_URL = 'https://wswhomo.afip.gov.ar/wsfe/service.asmx'

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
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      cabecera = { :id => id, :cantidadreg => items.size, :presta_serv => (esServicios ? 1 : 0)}
      detalle = { :FEDetalleRequest => items } 
      r = driver.fEAutRequest(ticket_to_arg(ticket).merge({ :Fer => { :Fecr => cabecera, :Fedr => detalle }}))
      write_log
      return r
    end

    def self.recuperaMaxQty(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      r = driver.fERecuperaQTYRequest(ticket_to_arg(ticket))
      write_log
      return WSFE::Response.new(r, :fERecuperaQTYRequestResult, :qty)
    end

    def self.recuperaUltNroTransaccion(ticket, log_file=nil)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      r = driver.fEUltNroRequest(ticket_to_arg(ticket))
      write_log
      return WSFE::Response.new(r, :fEUltNroRequestResult, :nro)
    end

    def self.recuperaUltNroCbte(ticket, puntoVta, tipoCbte, log_file=nil)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      r = driver.fERecuperaLastCMPRequest(ticket_to_arg(ticket).merge({ :argTCMP => { :PtoVta => puntoVta, :TipoCbte => tipoCbte }}))
      write_log
      return WSFE::Response.new(r, :fERecuperaLastCMPRequestResult, :cbte_nro)
    end

    def self.test(log_file=nil)
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      r = driver.fEDummy(nil)
      write_log
      "authserver=#{r.fEDummyResult.authserver}; appserver=#{r.fEDummyResult.appserver}; dbserver=#{r.fEDummyResult.dbserver};"
    end

    def self.verificaCAE(ticket, cae, cuit, puntoVta, tipoCbte, nroCbte, importe, fecha, log_file=nil)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      prepare_log(log_file, driver)
      r = driver.fEConsultaCAERequest(ticket_to_arg(ticket).merge({ :argCAERequest => { :cuit_emisor => cuit, :tipo_cbte => tipoCbte, :punto_vta => puntoVta, :cbt_nro => nroCbte, :imp_total => importe, :cae => cae, :fecha_cbte => fecha }}))
      write_log
      return WSFE::Response.new(r, :fEConsultaCAERequestResult, :resultado)
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

    def self.prepare_log(log_file, driver)
      @@log_file = log_file
      @@wiredump = ''
      if @@log_file
        driver.wiredump_dev = @@wiredump
      end
    end

    def self.write_log
      if @@log_file
        File.open(@@log_file, 'w') { |f| f.write @@wiredump }
      end
    end

    def self.ticket_missing
      WSFE::Response.new(nil, :nil, nil)
    end

    def self.ticket_to_arg(ticket)
      return { :argAuth => { :Token => ticket.token, :Sign => ticket.sign, :cuit => ticket.cuit } }
    end
  end

end
