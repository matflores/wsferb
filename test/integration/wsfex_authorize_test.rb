require "test_helper"

Protest.describe "WSFEX Authorize" do
  before do
    @fact = WSFEX::Fex.from_hash(FACTURA)
  end

  it "success" do
    input_file = expand_path("tmp/FEXAuthorizeInput.txt")
    output_file = expand_path("output/FEXAuthorizeOutput.txt")
    @fact.to_file(input_file)

    execute :FEXAuthorize, "#{input_file} #{output_file}"
    assert_success :FEXAuthorize
  end
end

FACTURA = {
  :Id                => 1234567890,
  :Fecha_cbte        => '20110301',
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
  :Moneda_ctz        => 4.00,
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
