require 'time'
require 'soap/wsdlDriver'
require 'afip'
require 'wsaa'

module WSFE

  class Client < AFIP::Client

    WSDL = File.dirname(__FILE__) + '/wsfe.wsdl'
    PROD_URL = 'https://servicios1.afip.gov.ar/wsfe/service.asmx'
    TEST_URL = 'https://wswhomo.afip.gov.ar/wsfe/service.asmx'

    def self.factura_lote(ticket, id, cuit, esServicios, lote, salida=nil, xml_file=nil)
      return ticket_missing if ticket.nil?
      items = read_items_from_file(cuit, esServicios, lote)
      r = self.factura_items(ticket, id, esServicios, items, xml_file)
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
                                  d.imp_total, d.imp_tot_conc, d.imp_neto, d.impto_liq, d.impto_liq_rni, d.imp_op_ex,
                                  d.cae, d.fecha_vto, d.motivo, d.fecha_serv_desde, d.fecha_serv_hasta, d.fecha_venc_pago ]
          end
        end
        out.close
      end
      return r
    end

    def self.factura_items(ticket, id, esServicios, items, xml_file=nil)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      if xml_file
        wiredump = ''
        driver.wiredump_dev = wiredump
      end
      r = driver.fEAutRequest(ticket.to_arg.merge({ :Fer => { :Fecr => { :id => id, :cantidadreg => items.size, :presta_serv => (esServicios ? 1 : 0)}, :Fedr => items }}))
      if xml_file
        xml_response = []
        response_found = false
        lines = wiredump.split("\n")
        lines.each { |l| response_found ? xml_response << l : if l == '= Response' then response_found = true end }
        xml_response.shift
        File.open(xml_file, 'w') { |f| f.write xml_response.join("\n") }
      end
    end

    def self.recuperaMaxQty(ticket)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      r = driver.fERecuperaQTYRequest(ticket.to_arg)
      return WSFE::Response.new(r, :fERecuperaQTYRequestResult, :qty)
    end

    def self.recuperaUltNroTransaccion(ticket)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      r = driver.fEUltNroRequest(ticket.to_arg)
      return WSFE::Response.new(r, :fEUltNroRequestResult, :nro)
    end

    def self.recuperaUltNroCbte(ticket, puntoVta, tipoCbte)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      r = driver.fERecuperaLastCMPRequest(ticket.to_arg.merge({ :argTCMP => { :PtoVta => puntoVta, :TipoCbte => tipoCbte }}))
      return WSFE::Response.new(r, :fERecuperaLastCMPRequestResult, :cbte_nro)
    end

    def self.test
      driver = create_rpc_driver
      r = driver.fEDummy(nil)
      "authserver=#{r.fEDummyResult.authserver}; appserver=#{r.fEDummyResult.appserver}; dbserver=#{r.fEDummyResult.dbserver};"
    end

    def self.verificaCAE(ticket, cae, cuit, puntoVta, tipoCbte, nroCbte, importe, fecha)
      return ticket_missing if ticket.nil?
      driver = create_rpc_driver
      r = driver.fEConsultaCAERequest(ticket.to_arg.merge({ :argCAERequest => { :cuit_emisor => cuit, :tipo_cbte => tipoCbte, :punto_vta => puntoVta, :cbt_nro => nroCbte, :imp_total => importe, :cae => cae, :fecha_cbte => fecha }}))
      return WSFE::Response.new(r, :fEConsultaCAERequestResult, :resultado)
    end

    def self.read_items_from_file(cuit, esServicios, lote)
      items = []
      lines = File.readlines(lote)
      lines.each do |line|
        fields = line.unpack('A1A8A2A1A4A8A8A3A2A11A30A15A15A15A15A15A15A15A15A15A15A8A8A8A6A1A1A14A8A8')
        unless esServicios
          fields[21] = fields[22] = fields[23] = '00000000'
        end
        items << {
                   :tipo_doc         => fields[8],
                   :nro_doc          => fields[9],
                   :tipo_cbte        => fields[02],
                   :punto_vta        => fields[4],
                   :cbt_desde        => fields[5],
                   :cbt_hasta        => fields[6],
                   :imp_total        => fields[11],
                   :imp_tot_conc     => fields[12],
                   :imp_neto         => fields[13],
                   :impto_liq        => fields[14],
                   :impto_liq_rni    => fields[15],
                   :imp_op_ex        => fields[16],
                   :fecha_cbte       => fields[1],
                   :fecha_serv_desde => fields[21],
                   :fecha_serv_hasta => fields[22],
                   :fecha_venc_pago  => fields[23]
                 } if fields[0] == '1'
      end
      items
    end

    def self.ticket_missing
      WSFE::Response.new(nil, :nil, nil)
    end

  end

end
