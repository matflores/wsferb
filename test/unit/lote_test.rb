require "test_helper"

Protest.describe "A WSFE::Lote" do
  it "can be imported from a hash" do
    lote = WSFErb::WSFE::Lote.from_hash(LOTE_INPUT, :fe_cab_req, :fe_det_req, :fecae_det_request)

    assert_equal 1, lote.comprobantes.size
  end

  it "can be exported to a hash" do
    lote = WSFErb::WSFE::Lote.new(01, 0001)
    cbte = WSFErb::WSFE::Cbte.new

    cbte.nro_cbte_desde   = 00000001
    cbte.nro_cbte_hasta   = 00000001
    cbte.concepto         = 02
    cbte.tipo_doc         = 80
    cbte.nro_doc          = 20238883890
    cbte.fecha_cbte       = "20110501"
    cbte.imp_total        = 1260.0
    cbte.imp_tot_conc     = 0.0
    cbte.imp_neto         = 1000.0
    cbte.imp_op_ex        = 0.0
    cbte.imp_iva          = 210.0
    cbte.imp_trib         = 50.0
    cbte.fecha_serv_desde = "20110401"
    cbte.fecha_serv_hasta = "20110430"
    cbte.fecha_vto        = "20110531"
    cbte.moneda           = "PES"
    cbte.cotizacion       = 1.0
    cbte.caea             = "12345678901234"
    cbte.cae              = "12345678901234"
    cbte.fecha_vto_cae    = "20110531"
    cbte.resultado        = "S"

    cbte.comprobantes  << { :Tipo => 02, :PtoVta => 0001, :Nro => 1230 }
    cbte.comprobantes  << { :Tipo => 02, :PtoVta => 0001, :Nro => 1231 }

    cbte.iva           << { :Id => 05, :BaseImp => 1000.0, :Importe => 210.0 }
    cbte.tributos      << { :Id => 01, :Desc => "Impuesto Nacional", :BaseImp => 1000.0, :Alic => 5, :Importe => 50.0 }
    cbte.opcionales    << { :Id => 01, :Valor => "Dato Opcional" }
    cbte.observaciones << { :Code => 000001, :Msg => "Observaciones" }

    lote.add(cbte)

    assert_equal LOTE_OUTPUT, lote.to_hash(:FeCabReq, :FeDetReq, :FEDetRequest)
  end

  it "can be imported from a text file" do
    lote = WSFErb::WSFE::Lote.load(expand_path("fixtures/lote_input.txt"))

    assert_equal 1, lote.comprobantes.size

    cbte = lote.get(00000001, 00000001)

    assert_equal 00000001           , cbte.nro_cbte_desde
    assert_equal 00000001           , cbte.nro_cbte_hasta
    assert_equal 02                 , cbte.concepto
    assert_equal 80                 , cbte.tipo_doc
    assert_equal 20238883890        , cbte.nro_doc
    assert_equal "20110501"         , cbte.fecha_cbte
    assert_equal 1260.0             , cbte.imp_total
    assert_equal 0.0                , cbte.imp_tot_conc
    assert_equal 1000.0             , cbte.imp_neto
    assert_equal 0.0                , cbte.imp_op_ex
    assert_equal 210.0              , cbte.imp_iva
    assert_equal 50.0               , cbte.imp_trib
    assert_equal "20110401"         , cbte.fecha_serv_desde
    assert_equal "20110430"         , cbte.fecha_serv_hasta
    assert_equal "20110531"         , cbte.fecha_vto
    assert_equal "PES"              , cbte.moneda
    assert_equal 1.0                , cbte.cotizacion
    assert_equal "12345678901234"   , cbte.caea

    assert_equal 2                  , cbte.comprobantes.size
    assert_equal 02                 , cbte.comprobantes[0][:Tipo]
    assert_equal 0001               , cbte.comprobantes[0][:PtoVta]
    assert_equal 1230               , cbte.comprobantes[0][:Nro]
    assert_equal 02                 , cbte.comprobantes[1][:Tipo]
    assert_equal 0001               , cbte.comprobantes[1][:PtoVta]
    assert_equal 1231               , cbte.comprobantes[1][:Nro]

    assert_equal 1                  , cbte.iva.size
    assert_equal 05                 , cbte.iva[0][:Id]
    assert_equal 1000.0             , cbte.iva[0][:BaseImp]
    assert_equal 210.0              , cbte.iva[0][:Importe]

    assert_equal 1                  , cbte.tributos.size
    assert_equal 01                 , cbte.tributos[0][:Id]
    assert_equal "Impuesto Nacional", cbte.tributos[0][:Desc]
    assert_equal 1000.0             , cbte.tributos[0][:BaseImp]
    assert_equal 5                  , cbte.tributos[0][:Alic]
    assert_equal 50.0               , cbte.tributos[0][:Importe]

    assert_equal 1                  , cbte.opcionales.size
    assert_equal 02                 , cbte.opcionales[0][:Id]
    assert_equal "Dato Opcional"    , cbte.opcionales[0][:Valor]

    assert_equal 1                  , cbte.observaciones.size
    assert_equal 000001             , cbte.observaciones[0][:Code]
    assert_equal "Observaciones"    , cbte.observaciones[0][:Msg]
  end

  it "can be exported to a text file" do
    lote_input  = expand_path("fixtures/lote_input.txt")
    lote_output = Tempfile.new("lote")

    lote = WSFErb::WSFE::Lote.load(lote_input)
    lote.save(lote_output.path)

    assert_equal File.read(lote_input).strip, File.read(lote_output).strip
  end

  it "should support multiple invoices" do
    lote_input  = expand_path("fixtures/lote_input_multi.txt")
    lote_output = Tempfile.new("lote")

    lote = WSFErb::WSFE::Lote.load(lote_input)
    lote.save(lote_output.path)

    assert_equal File.read(lote_input).strip, File.read(lote_output).strip
  end
end

LOTE_INPUT = {
  :fe_cab_req => {
    :cant_reg  => 1,
    :cbte_tipo => 01,
    :pto_vta   => 0001,
  },
  :fe_det_req => {
    :fecae_det_request => [{
      :cbte_desde     => 00000001,
      :cbte_hasta     => 00000001,
      :concepto       => 02,
      :doc_tipo       => 80,
      :doc_nro        => 23188883354,
      :cbte_fch       => "20110501",
      :imp_total      => 1260.0,
      :imp_tot_conc   => 0.0,
      :imp_neto       => 1000.0,
      :imp_op_ex      => 0.0,
      :imp_iva        => 210.0,
      :imp_trib       => 50.0,
      :fch_serv_desde => "20110401",
      :fch_serv_hasta => "20110430",
      :fch_vto_pago   => "20110531",
      :mon_id         => "PES",
      :mon_cotiz      => 1.0,
      :caea           => "12345678901234",
      :cae            => "12345678901234",
      :cae_fch_vto    => "20110531",
      :resultado      => "S",
      :cbtes_asoc     => { :cbte_asoc => [ { :tipo => 02, :pto_vta => 0001, :nro => 1230 },
                                           { :tipo => 02, :pto_vta => 0001, :nro => 1231 } ] },
      :iva            => { :alic_iva => [ { :id => 05, :base_imp => 1000.0, :importe => 210.0 } ] },
      :tributos       => { :tributo => [ { :id => 01, :desc => "Impuesto Nacional", :base_imp => 1000.0, :alic => 5, :importe => 50.0 } ] },
      :opcionales     => { :opcional => [ { :id => 02, :valor => 1234 } ] },
      :observaciones  => { :obs => [ { :code => 000001, :msg => "Observaciones" } ] }
    }]
  }
}

LOTE_OUTPUT = {
  :FeCabReq => {
    :CantReg  => 1,
    :CbteTipo => 01,
    :PtoVta   => 0001,
  },
  :FeDetReq => {
    :FEDetRequest => [{
      :CbteDesde     => 00000001,
      :CbteHasta     => 00000001,
      :Concepto      => 02,
      :DocTipo       => 80,
      :DocNro        => 20238883890,
      :CbteFch       => "20110501",
      :ImpTotal      => 1260.0,
      :ImpTotConc    => 0.0,
      :ImpNeto       => 1000.0,
      :ImpOpEx       => 0.0,
      :ImpIVA        => 210.0,
      :ImpTrib       => 50.0,
      :FchServDesde  => "20110401",
      :FchServHasta  => "20110430",
      :FchVtoPago    => "20110531",
      :MonId         => "PES",
      :MonCotiz      => 1.0,
      :Caea          => "12345678901234",
      :Cae           => "12345678901234",
      :CaeFchVto     => "20110531",
      :Resultado     => "S",
      :CbtesAsoc     => { :CbteAsoc => [ { :Tipo => 02, :PtoVta => 0001, :Nro => 1230 },
                                         { :Tipo => 02, :PtoVta => 0001, :Nro => 1231 } ] },
      :Iva           => { :AlicIva => [ { :Id => 05, :BaseImp => 1000.0, :Importe => 210.0 } ] },
      :Tributos      => { :Tributo => [ { :Id => 01, :Desc => "Impuesto Nacional", :BaseImp => 1000.0, :Alic => 5, :Importe => 50.0 } ] },
      :Opcionales    => { :Opcional => [ { :Id => 01, :Valor => "Dato Opcional" } ] },
      :Observaciones => { :Obs => [ { :Code => 000001, :Msg => "Observaciones" } ] }
    }]
  }
}

