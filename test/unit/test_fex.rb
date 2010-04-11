require 'test_helper'

Protest.describe "A FEX invoice" do
  it "can be imported from a hash" do
    fex = WSFEX::Fex.from_hash(FACTURA)

    assert_equal 1234567890                  , fex.id_cbte
    assert_equal 19                          , fex.tipo_cbte
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
    assert_equal 'Motivos'                   , fex.motivos
  end

  it "can be exported to a hash" do
    fex                 = WSFEX::Fex.new
    fex.id_cbte         = 1234567890
    fex.tipo_cbte       = 19
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
    fex.motivos         = 'Motivos'
    fex.obs             = 'Observaciones'
    fex.obs_comerciales = 'Observaciones Comerciales'

    assert_equal FACTURA, fex.to_hash
  end

  it "can be imported from a text file" do
    fex = WSFEX::Fex.from_file(expand_pathname('fex_input.txt'))

    assert_equal 1234567890                  , fex.id_cbte
    assert_equal 19                          , fex.tipo_cbte
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
    assert_equal 'Motivos'                   , fex.motivos
  end

  it "can be exported to a text file" do
    fex = WSFEX::Fex.from_file(expand_pathname('fex_input.txt'))
    fex.to_file expand_pathname('fex_output.txt')

    assert_equal File.read(expand_pathname('fex_input.txt')), File.read(expand_pathname('fex_output.txt'))
  end

  def expand_pathname(filename)
    File.dirname(__FILE__) + '/../samples/' + filename
  end
end

#HOY = Time.now
#VTO = Time.local(HOY.year, HOY.month == 12 ? 1 : HOY.month + 1, HOY.day)

FACTURA = {
      :id_cbte          => 1234567890,
      :tipo_cbte        => 19,
      :punto_vta        => 0001,
      :nro_cbte         => 1234,
      :fecha_cbte       => '20100301',
      :tipo_expo        => 1,
      :tiene_permiso    => 'S',
      :pais             => 310,
      :cuit_pais        => 12345678901,
      :id_impositivo    => '1234567890',
      :cliente          => 'Kung Fu',
      :domicilio        => '123 St',
      :moneda           => 'DOL',
      :cotizacion       => 3.80,
      :total            => 1000,
      :forma_pago       => 'Contado',
      :idioma           => 1,
      :incoterms        => 'INC',
      :incoterms_info   => 'Incoterms',
      :obs              => 'Observaciones',
      :obs_comerciales  => 'Observaciones Comerciales',
      :cae              => '12345678901234',
      :fecha_cae        => '20100301',
      :fecha_vto_cae    => '20100331',
      :resultado        => 'S',
      :motivos          => 'Motivos'
    }
#      :permisos         => [ { :id_permiso => '1234567890123456', :pais => 310 },
#                             { :id_permiso => '1234567890ABCDEF', :pais => 320 } ],
#      :comprobantes     => [ { :tipo_cbte => 20, :punto_vta => 0001, :nro_cbte => 1230 },
#                             { :tipo_cbte => 21, :punto_vta => 0001, :nro_cbte => 1231 } ],
#      :items            => [ { :codigo => '12345', :descripcion => 'Item 1', :quantity => 100, :umed => 01, :precio => 10, :total => 1000 },
#                             { :codigo => '54321', :descripcion => 'Item 2', :quantity => 200, :umed => 01, :precio => 10, :total => 2000 } ]
#    }
