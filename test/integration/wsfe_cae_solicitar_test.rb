require "test_helper"

Protest.describe "FECAESolicitar" do
  before do
    @lote = WSFErb::WSFE::Lote.from_hash(LOTE, :fe_cab_req, :fe_det_req, :fecae_det_request)

    @cbte = @lote.comprobantes.values.first
    @cbte.nro_cbte_desde = last_nro_cbte_used(@lote.tipo_cbte, @lote.punto_vta) + 1
    @cbte.nro_cbte_hasta = @cbte.nro_cbte_desde

    @input_file = expand_path("tmp/FECAESolicitarInput.txt")
    @output_file = expand_path("tmp/FECAESolicitarOutput.txt")
  end

  it "success" do
    @lote.save(@input_file)

    execute :FECAESolicitar, @input_file

    assert_success :FECAESolicitar
  end

  it "should fail if the specified credentials are not valid" do
    @lote.save(@input_file)

    execute :FECAESolicitar, @input_file, "--cuit 12345678910 --cert #{CERT_FILE} --key #{KEY_FILE}"
 
    assert_error_code :FECAESolicitar, 600
  end
 
  it "should fail if there are no invoices in this set" do
    @lote.comprobantes = {}
    @lote.save(@input_file)
 
    execute :FECAESolicitar, @input_file
 
    assert_error_code :FECAESolicitar, 10001
  end
 
  it "should fail if punto_vta is invalid" do
    @lote.punto_vta = "9999"
    @lote.save(@input_file)

    execute :FECAESolicitar, @input_file

    assert_error_code :FECAESolicitar, 10004
  end

  it "should fail if tipo_cbte is invalid" do
    @lote.tipo_cbte = 0
    @lote.save(@input_file)

    execute :FECAESolicitar, @input_file

    assert_error_code :FECAESolicitar, 10006
  end

  it "should fail if tipo_cbte is unknown" do
    @lote.tipo_cbte = 990
    @lote.save(@input_file)

    execute :FECAESolicitar, @input_file

    assert_error_code :FECAESolicitar, 10007
  end

  it "should fail if nro_cbte_desde is invalid" do
    @cbte.nro_cbte_desde = 0
    @lote.save(@input_file)

    execute :FECAESolicitar, @input_file

    assert_error_code :FECAESolicitar, 10008
  end

  it "should fail if fecha_cbte is invalid" do
    @cbte.fecha_cbte = "20100101"
    @lote.save(@input_file)

    execute :FECAESolicitar, @input_file

    assert_error_code :FECAESolicitar, 10016
  end

  def last_nro_cbte_used(tipo_cbte, punto_vta)
    execute :FECompUltimoAutorizado, "#{tipo_cbte} #{punto_vta}"
    response = WSFErb::Response.load(expand_path("tmp/FECompUltimoAutorizado.txt"))
    response.value.to_i
  end

  def script
    "wsfe"
  end
end

LOTE = {
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
      :iva            => { :alic_iva => [ { :id => 05, :base_imp => 1000.0, :importe => 210.0 } ] },
      :tributos       => { :tributo => [ { :id => 01, :desc => "Impuesto Nacional", :base_imp => 1000.0, :alic => 5, :importe => 50.0 } ] },
      :opcionales     => { :opcional => [ { :id => 02, :valor => 1234 } ] },
      :observaciones  => { :obs => [ { :code => 000001, :msg => "Observaciones" } ] }
    }]
  }
}
