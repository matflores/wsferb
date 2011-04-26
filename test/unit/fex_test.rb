require "test_helper"

Protest.describe "A FEX invoice" do
  it "can be imported from a hash" do
    fex = WSFEX::Fex.from_hash(FACTURA_CON_CAE)

    assert_equal 1234567890                  , fex.id_cbte
    assert_equal 20                          , fex.tipo_cbte
    assert_equal 0001                        , fex.punto_vta
    assert_equal 1234                        , fex.nro_cbte
    assert_equal '20100301'                  , fex.fecha_cbte
    assert_equal 1                           , fex.tipo_expo
    assert_equal 'S'                         , fex.tiene_permiso
    assert_equal 310                         , fex.pais
    assert_equal 12345678901                 , fex.cuit_pais
    assert_equal '1234567890'                , fex.id_impositivo
    assert_equal 'Kung Fu'                   , fex.cliente
    assert_equal '123 St'                    , fex.domicilio
    assert_equal 'DOL'                       , fex.moneda
    assert_equal 3.8                         , fex.cotizacion
    assert_equal 1000                        , fex.total
    assert_equal 'Contado'                   , fex.forma_pago
    assert_equal 1                           , fex.idioma
    assert_equal 'INC'                       , fex.incoterms
    assert_equal 'Incoterms'                 , fex.incoterms_info
    assert_equal 'Observaciones'             , fex.obs
    assert_equal 'Observaciones Comerciales' , fex.obs_comerciales
    assert_equal '12345678901234'            , fex.cae
    assert_equal '20100301'                  , fex.fecha_cae
    assert_equal '20100331'                  , fex.fecha_vto_cae
    assert_equal 'S'                         , fex.resultado

    assert_equal 2                           , fex.permisos.size
    assert_equal '1234567890123456'          , fex.permisos[0][:Id_permiso]
    assert_equal 310                         , fex.permisos[0][:Dst_merc]
    assert_equal '1234567890ABCDEF'          , fex.permisos[1][:Id_permiso]
    assert_equal 310                         , fex.permisos[1][:Dst_merc]

    assert_equal 2                           , fex.comprobantes.size
    assert_equal 19                          , fex.comprobantes[0][:CBte_tipo]
    assert_equal 0001                        , fex.comprobantes[0][:Cbte_punto_vta]
    assert_equal 1230                        , fex.comprobantes[0][:Cbte_nro]
    assert_equal 21                          , fex.comprobantes[1][:CBte_tipo]
    assert_equal 0001                        , fex.comprobantes[1][:Cbte_punto_vta]
    assert_equal 1231                        , fex.comprobantes[1][:Cbte_nro]

    assert_equal 2                           , fex.items.size
    assert_equal '12345'                     , fex.items[0][:Pro_codigo]
    assert_equal 'Item 1'                    , fex.items[0][:Pro_ds]
    assert_equal 100                         , fex.items[0][:Pro_qty]
    assert_equal 10.0                        , fex.items[0][:Pro_precio_uni]
    assert_equal 1000.0                      , fex.items[0][:Pro_total_item]
    assert_equal '54321'                     , fex.items[1][:Pro_codigo]
    assert_equal 'Item 2'                    , fex.items[1][:Pro_ds]
    assert_equal 200                         , fex.items[1][:Pro_qty]
    assert_equal 10.0                        , fex.items[1][:Pro_precio_uni]
    assert_equal 2000.0                      , fex.items[1][:Pro_total_item]
  end

  it "can be exported to a hash" do
    fex                 = WSFEX::Fex.new

    fex.id_cbte         = 1234567890
    fex.tipo_cbte       = 20
    fex.punto_vta       = 0001
    fex.nro_cbte        = 1234
    fex.fecha_cbte      = '20100301'
    fex.tipo_expo       = 1
    fex.tiene_permiso   = 'S'
    fex.pais            = 310
    fex.cuit_pais       = 12345678901
    fex.id_impositivo   = '1234567890'
    fex.cliente         = 'Kung Fu'
    fex.domicilio       = '123 St'
    fex.moneda          = 'DOL'
    fex.cotizacion      = 3.8
    fex.total           = 1000
    fex.forma_pago      = 'Contado'
    fex.idioma          = 1
    fex.incoterms       = 'INC'
    fex.incoterms_info  = 'Incoterms'
    fex.cae             = '12345678901234'
    fex.fecha_cae       = '20100301'
    fex.fecha_vto_cae   = '20100331'
    fex.resultado       = 'S'
    fex.obs             = 'Observaciones'
    fex.obs_comerciales = 'Observaciones Comerciales'

    fex.permisos << { :Id_permiso => '1234567890123456', :Dst_merc => 310 }
    fex.permisos << { :Id_permiso => '1234567890ABCDEF', :Dst_merc => 310 }

    fex.comprobantes << { :CBte_tipo => 19, :Cbte_punto_vta => 0001, :Cbte_nro => 1230 }
    fex.comprobantes << { :CBte_tipo => 21, :Cbte_punto_vta => 0001, :Cbte_nro => 1231 }

    fex.items << { :Pro_codigo => '12345', :Pro_ds => 'Item 1', :Pro_qty => 100, :Pro_umed => 01, :Pro_precio_uni => 10.0, :Pro_total_item => 1000.0 }
    fex.items << { :Pro_codigo => '54321', :Pro_ds => 'Item 2', :Pro_qty => 200, :Pro_umed => 01, :Pro_precio_uni => 10.0, :Pro_total_item => 2000.0 }

    assert_equal FACTURA_CON_CAE, fex.to_hash(true)
    assert_equal FACTURA_SIN_CAE, fex.to_hash(false)
  end

  it "can be imported from a text file" do
    fex = WSFEX::Fex.from_file(expand_path("fixtures/fex_input.txt"))

    assert_equal 1234567890                  , fex.id_cbte
    assert_equal 20                          , fex.tipo_cbte
    assert_equal 0001                        , fex.punto_vta
    assert_equal 1234                        , fex.nro_cbte
    assert_equal '20100301'                  , fex.fecha_cbte
    assert_equal 1                           , fex.tipo_expo
    assert_equal 'S'                         , fex.tiene_permiso
    assert_equal 310                         , fex.pais
    assert_equal 12345678901                 , fex.cuit_pais
    assert_equal '1234567890'                , fex.id_impositivo
    assert_equal 'Kung Fu'                   , fex.cliente
    assert_equal '123 St'                    , fex.domicilio
    assert_equal 'DOL'                       , fex.moneda
    assert_equal 3.8                         , fex.cotizacion
    assert_equal 1000                        , fex.total
    assert_equal 'Contado'                   , fex.forma_pago
    assert_equal 1                           , fex.idioma
    assert_equal 'INC'                       , fex.incoterms
    assert_equal 'Incoterms'                 , fex.incoterms_info
    assert_equal 'Observaciones'             , fex.obs
    assert_equal 'Observaciones Comerciales' , fex.obs_comerciales
    assert_equal '12345678901234'            , fex.cae
    assert_equal '20100301'                  , fex.fecha_cae
    assert_equal '20100331'                  , fex.fecha_vto_cae
    assert_equal 'S'                         , fex.resultado

    assert_equal 2                           , fex.permisos.size
    assert_equal '1234567890123456'          , fex.permisos[0][:Id_permiso]
    assert_equal 310                         , fex.permisos[0][:Dst_merc]
    assert_equal '1234567890ABCDEF'          , fex.permisos[1][:Id_permiso]
    assert_equal 310                         , fex.permisos[1][:Dst_merc]

    assert_equal 2                           , fex.comprobantes.size
    assert_equal 19                          , fex.comprobantes[0][:CBte_tipo]
    assert_equal 0001                        , fex.comprobantes[0][:Cbte_punto_vta]
    assert_equal 1230                        , fex.comprobantes[0][:Cbte_nro]
    assert_equal 21                          , fex.comprobantes[1][:CBte_tipo]
    assert_equal 0001                        , fex.comprobantes[1][:Cbte_punto_vta]
    assert_equal 1231                        , fex.comprobantes[1][:Cbte_nro]

    assert_equal 2                           , fex.items.size
    assert_equal '12345'                     , fex.items[0][:Pro_codigo]
    assert_equal 'Item 1'                    , fex.items[0][:Pro_ds]
    assert_equal 100                         , fex.items[0][:Pro_qty]
    assert_equal 10.0                        , fex.items[0][:Pro_precio_uni]
    assert_equal 1000.0                      , fex.items[0][:Pro_total_item]
    assert_equal '54321'                     , fex.items[1][:Pro_codigo]
    assert_equal 'Item 2'                    , fex.items[1][:Pro_ds]
    assert_equal 200                         , fex.items[1][:Pro_qty]
    assert_equal 10.0                        , fex.items[1][:Pro_precio_uni]
    assert_equal 2000.0                      , fex.items[1][:Pro_total_item]
  end

  it "can be exported to a text file" do
    fex_input  = expand_path("fixtures/fex_input.txt")
    fex_output = Tempfile.new("fex")

    fex = WSFEX::Fex.from_file(fex_input)
    fex.to_file(fex_output.path)

    assert_equal File.read(fex_input), File.read(fex_output)
  end
end

FACTURA_CON_CAE = {
  :Id                => 1234567890,
  :Fecha_cbte        => '20100301',
  :Tipo_cbte         => 20,
  :Punto_vta         => 0001,
  :Cbte_nro          => 1234,
  :Tipo_expo         => 1,
  :Permiso_existente => 'S',
  :Dst_cmp           => 310,
  :Cliente           => 'Kung Fu',
  :Cuit_pais_cliente => 12345678901,
  :Domicilio_cliente => '123 St',
  :Id_impositivo     => '1234567890',
  :Moneda_Id         => 'DOL',
  :Moneda_ctz        => 3.80,
  :Obs_comerciales   => 'Observaciones Comerciales',
  :Imp_total         => 1000,
  :Obs               => 'Observaciones',
  :Forma_pago        => 'Contado',
  :Incoterms         => 'INC',
  :Incoterms_Ds      => 'Incoterms',
  :Idioma_cbte       => 1,
  :Cae               => '12345678901234',
  :Fecha_cbte_cae    => '20100301',
  :Fecha_venc_cae    => '20100331',
  :Resultado         => 'S',
  :Permisos          => { :Permiso  => [ { :Id_permiso => '1234567890123456', :Dst_merc => 310 },
                                         { :Id_permiso => '1234567890ABCDEF', :Dst_merc => 310 } ] },
  :Cmps_asoc         => { :Cmp_asoc => [ { :CBte_tipo => 19, :Cbte_punto_vta => 0001, :Cbte_nro => 1230 },
                                         { :CBte_tipo => 21, :Cbte_punto_vta => 0001, :Cbte_nro => 1231 } ] },
  :Items             => { :Item     => [ { :Pro_codigo => '12345', :Pro_ds => 'Item 1', :Pro_qty => 100, :Pro_umed => 01, :Pro_precio_uni => 10.0, :Pro_total_item => 1000.0 },
                                         { :Pro_codigo => '54321', :Pro_ds => 'Item 2', :Pro_qty => 200, :Pro_umed => 01, :Pro_precio_uni => 10.0, :Pro_total_item => 2000.0 } ] }
}

FACTURA_SIN_CAE = {
  :Id                => 1234567890,
  :Fecha_cbte        => '20100301',
  :Tipo_cbte         => 20,
  :Punto_vta         => 0001,
  :Cbte_nro          => 1234,
  :Tipo_expo         => 1,
  :Permiso_existente => 'S',
  :Dst_cmp           => 310,
  :Cliente           => 'Kung Fu',
  :Cuit_pais_cliente => 12345678901,
  :Domicilio_cliente => '123 St',
  :Id_impositivo     => '1234567890',
  :Moneda_Id         => 'DOL',
  :Moneda_ctz        => 3.80,
  :Obs_comerciales   => 'Observaciones Comerciales',
  :Imp_total         => 1000,
  :Obs               => 'Observaciones',
  :Forma_pago        => 'Contado',
  :Incoterms         => 'INC',
  :Incoterms_Ds      => 'Incoterms',
  :Idioma_cbte       => 1,
  :Permisos          => { :Permiso  => [ { :Id_permiso => '1234567890123456', :Dst_merc => 310 },
                                         { :Id_permiso => '1234567890ABCDEF', :Dst_merc => 310 } ] },
  :Cmps_asoc         => { :Cmp_asoc => [ { :CBte_tipo => 19, :Cbte_punto_vta => 0001, :Cbte_nro => 1230 },
                                         { :CBte_tipo => 21, :Cbte_punto_vta => 0001, :Cbte_nro => 1231 } ] },
  :Items             => { :Item     => [ { :Pro_codigo => '12345', :Pro_ds => 'Item 1', :Pro_qty => 100, :Pro_umed => 01, :Pro_precio_uni => 10.0, :Pro_total_item => 1000.0 },
                                         { :Pro_codigo => '54321', :Pro_ds => 'Item 2', :Pro_qty => 200, :Pro_umed => 01, :Pro_precio_uni => 10.0, :Pro_total_item => 2000.0 } ] }
}
