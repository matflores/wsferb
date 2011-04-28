require "test_helper"

Protest.describe "WSFE" do
  test_method :FEDummy
  test_method :FEParamGetTiposCbte
  test_method :FEParamGetTiposConcepto
  test_method :FEParamGetTiposDoc
  test_method :FEParamGetTiposIva
  test_method :FEParamGetTiposMonedas
  test_method :FEParamGetTiposOpcional
  test_method :FEParamGetTiposTributos
  test_method :FEParamGetPtosVenta

  test :FECompUltimoAutorizado do
    execute :FECompUltimoAutorizado, "01 0001"
    assert_value :FECompUltimoAutorizado, 1, 1000
  end

  test :FECompTotXRequest do
    execute :FECompTotXRequest
    assert_value :FECompTotXRequest, 250
  end

  def script
    "wsfe"
  end
end
