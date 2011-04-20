require "test_helper"

Protest.describe "WSFEX Authorize" do
  before do
    @fact = WSFEX::Fex.from_hash(FACTURA)
    @fact.id_cbte = last_id_cbte_used + 1
    @fact.nro_cbte = last_nro_cbte_used(@fact.tipo_cbte, @fact.punto_vta) + 1
    @input_file = expand_path("tmp/FEXAuthorizeInput.txt")
    @output_file = expand_path("tmp/FEXAuthorizeOutput.txt")
  end

  it "success" do
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_success :FEXAuthorize
  end

  it "should fail if the specified credentials are not valid" do
    @fact.to_file(@input_file)
 
    execute :FEXAuthorize, "#{@input_file} #{@output_file}", "--cuit 12345678910 --cert #{CERT_FILE} --key #{KEY_FILE}"
 
    assert_error_code :FEXAuthorize, 1000
  end
 
  it "should fail if a request id was not specified" do
    @fact.id_cbte = 0
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1014
  end

  it "should fail if fecha_cbte is invalid" do
    @fact.fecha_cbte = "20100101"
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1500
  end

  it "should fail if fecha_cbte does not follow the expected sequence" do
    @fact.fecha_cbte = (Date.today - 1).strftime("%Y%m%d")
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1535
  end

  it "should fail if punto_vta is invalid" do
    @fact.punto_vta = "9999"
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1510
  end

  it "should fail if tipo_cbte is invalid" do
    @fact.tipo_cbte = "01"
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1530
  end

  it "should fail if nro_cbte does not follow the expected sequence" do
    @fact.nro_cbte -= 1
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1535
  end

  it "should fail if tipo_expo is invalid" do
    @fact.tipo_expo = "9"
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1540
  end

  it "should fail if tiene_permiso is invalid" do
    @fact.tiene_permiso = "X"
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1550
  end

  it "should fail if moneda is invalid" do
    @fact.moneda = "XXX"
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1590
  end

  it "should fail if total does not match the sum of all items" do
    @fact.total = 1000.0
    @fact.to_file(@input_file)

    execute :FEXAuthorize, "#{@input_file} #{@output_file}"

    assert_error_code :FEXAuthorize, 1610
  end

  def last_id_cbte_used
    execute :FEXGetLastId
    response = parse_response(:FEXGetLastId)
    response.value.to_i
  end

  def last_nro_cbte_used(tipo_cbte, punto_vta)
    execute :FEXGetLastCmp, "#{tipo_cbte} #{punto_vta}"
    response = parse_response(:FEXGetLastCmp)
    response.value.to_i
  end

  def script
    "wsfex"
  end
end

FACTURA = {
  :Id                => 1234567890,
  :Fecha_cbte        => Date.today.strftime("%Y%m%d"),
  :Tipo_cbte         => 19,
  :Punto_vta         => 0001,
  :Cbte_nro          => 5,
  :Tipo_expo         => 1,
  :Permiso_existente => 'S',
  :Dst_cmp           => 310,
  :Cliente           => 'Kung Fu',
  :Cuit_pais_cliente => 50000003104,
  :Domicilio_cliente => '123 St',
  :Id_impositivo     => '1234567890',
  :Moneda_Id         => 'DOL',
  :Moneda_ctz        => 4.00,
  :Obs_comerciales   => 'Observaciones Comerciales',
  :Imp_total         => 3000,
  :Obs               => 'Observaciones',
  :Forma_pago        => 'Contado',
  :Incoterms         => 'DATDAT',
  :Incoterms_Ds      => 'Incoterms',
  :Idioma_cbte       => 1,
  :Permisos          => { :Permiso  => [ { :Id_permiso => '1234567890123456', :Dst_merc => 310 },
                                         { :Id_permiso => '1234567890ABCDEF', :Dst_merc => 310 } ] },
  :Items             => { :Item     => [ { :Pro_codigo => '12345', :Pro_ds => 'Item 1', :Pro_qty => 100, :Pro_umed => 01, :Pro_precio_uni => 10.0, :Pro_total_item => 1000.0 },
                                         { :Pro_codigo => '54321', :Pro_ds => 'Item 2', :Pro_qty => 200, :Pro_umed => 01, :Pro_precio_uni => 10.0, :Pro_total_item => 2000.0 } ] }
}
