require "test_helper"

Protest.describe "A WSFE::Cbte" do
  it "can be imported from a hash" do
    cbte = WSFErb::WSFE::Cbte.from_hash(CBTE)

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
    assert_equal 0001               , cbte.comprobantes[0][:Pto_vta]
    assert_equal 1230               , cbte.comprobantes[0][:Nro]
    assert_equal 02                 , cbte.comprobantes[1][:Tipo]
    assert_equal 0001               , cbte.comprobantes[1][:Pto_vta]
    assert_equal 1231               , cbte.comprobantes[1][:Nro]

    assert_equal 1                  , cbte.iva.size
    assert_equal 05                 , cbte.iva[0][:Id]
    assert_equal 1000.0             , cbte.iva[0][:Base_imp]
    assert_equal 210.0              , cbte.iva[0][:Importe]

    assert_equal 1                  , cbte.tributos.size
    assert_equal 01                 , cbte.tributos[0][:Id]
    assert_equal "Impuesto Nacional", cbte.tributos[0][:Desc]
    assert_equal 1000.0             , cbte.tributos[0][:Base_imp]
    assert_equal 5                  , cbte.tributos[0][:Alic]
    assert_equal 50.0               , cbte.tributos[0][:Importe]

    assert_equal 1                  , cbte.opcionales.size
    assert_equal 01                 , cbte.opcionales[0][:Id]
    assert_equal "Dato Opcional"    , cbte.opcionales[0][:Valor]

    assert_equal 1                  , cbte.observaciones.size
    assert_equal 000001             , cbte.observaciones[0][:Code]
    assert_equal "Observaciones"    , cbte.observaciones[0][:Msg]
  end

  it "can be exported to a hash" do
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

    cbte.comprobantes  << { :Tipo => 02, :Pto_vta => 0001, :Nro => 1230 }
    cbte.comprobantes  << { :Tipo => 02, :Pto_vta => 0001, :Nro => 1231 }

    cbte.iva           << { :Id => 05, :Base_imp => 1000.0, :Importe => 210.0 }
    cbte.tributos      << { :Id => 01, :Desc => "Impuesto Nacional", :Base_imp => 1000.0, :Alic => 5, :Importe => 50.0 }
    cbte.opcionales    << { :Id => 01, :Valor => "Dato Opcional" }
    cbte.observaciones << { :Code => 000001, :Msg => "Observaciones" }

    assert_equal CBTE, cbte.to_hash
  end
end

CBTE = {
  :Cbte_desde     => 00000001,
  :Cbte_hasta     => 00000001,
  :Concepto       => 02,
  :Doc_tipo       => 80,
  :Doc_nro        => 20238883890,
  :Cbte_fch       => "20110501",
  :Imp_total      => 1260.0,
  :Imp_tot_conc   => 0.0,
  :Imp_neto       => 1000.0,
  :Imp_op_ex      => 0.0,
  :Imp_iva        => 210.0,
  :Imp_trib       => 50.0,
  :Fch_serv_desde => "20110401",
  :Fch_serv_hasta => "20110430",
  :Fch_vto_pago   => "20110531",
  :Mon_id         => "PES",
  :Mon_cotiz      => 1.0,
  :Caea           => "12345678901234",
  :Cae            => "12345678901234",
  :Cae_fch_vto    => "20110531",
  :Resultado      => "S",
  :Cbtes_asoc     => { :Cbte_asoc => [ { :Tipo => 02, :Pto_vta => 0001, :Nro => 1230 },
                                       { :Tipo => 02, :Pto_vta => 0001, :Nro => 1231 } ] },
  :Iva            => { :Alic_iva => [ { :Id => 05, :Base_imp => 1000.0, :Importe => 210.0 } ] },
  :Tributos       => { :Tributo => [ { :Id => 01, :Desc => "Impuesto Nacional", :Base_imp => 1000.0, :Alic => 5, :Importe => 50.0 } ] },
  :Opcionales     => { :Opcional => [ { :Id => 01, :Valor => "Dato Opcional" } ] },
  :Obs            => { :Observaciones => [ { :Code => 000001, :Msg => "Observaciones" } ] }
}
