require "test_helper"

Protest.describe "WSFE" do
  describe "FEDummy" do
    test_method :FEDummy
  end

  describe "FECAEAConsultar"
  describe "FECAEARegInformativo"
  describe "FECAEASinMovimientoConsultar"
  describe "FECAEASinMovimientoInformar"
  describe "FECAEASinMovimientoInformar"
  describe "FECAEASolicitar"
  describe "FECAESolicitar"
  describe "FECompConsultar"

  describe "FECompTotXRequest" do
    test "Success" do
      execute :FECompTotXRequest
      assert_value :FECompTotXRequest, 250
    end

    test_common_errors(:FECompTotXRequest)
  end

  describe "FECompUltimoAutorizado" do
    test "Success" do
      execute :FECompUltimoAutorizado, "01 0001"
      assert_value :FECompUltimoAutorizado, 1, 1000
    end

    test_common_errors(:FECompUltimoAutorizado, "01 0001")
  end

  describe "FEParamGetCotizacion" do
    test "Success" do
      execute :FEParamGetCotizacion, "DOL"

      response = WSFErb::Response.load(expand_path("tmp/FEParamGetCotizacion.txt"))

      mon_id  = response.value[0..2]
      mon_ctz = response.value[3..14].to_f / 1000000

      assert_equal "DOL", mon_id
      assert mon_ctz >= 3.5 && mon_ctz <= 4.5
    end

    test_common_errors(:FEParamGetCotizacion, "DOL")
  end

  [ :FEParamGetPtosVenta,
    :FEParamGetTiposCbte,
    :FEParamGetTiposConcepto,
    :FEParamGetTiposDoc,
    :FEParamGetTiposIva,
    :FEParamGetTiposMonedas,
    :FEParamGetTiposOpcional,
    :FEParamGetTiposTributos ].each do |service|

    describe(service.to_s) do
      test_method(service)
      test_common_errors(service)
    end

  end

  test_common_errors

  def script
    "wsfe"
  end
end
