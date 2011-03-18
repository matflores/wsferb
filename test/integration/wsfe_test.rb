require "test_helper"

Protest.describe "WSFE" do
  test_method :FEDummy
  test_method :FEParamGetTiposCbte

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
