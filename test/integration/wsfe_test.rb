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
      assert_value :FEParamGetCotizacion, 3.5, 4.5
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
