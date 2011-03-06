require "test_helper"

Protest.describe "WSFE" do
  test_method :FEDummy

  test :FEUltNroRequest do
    execute :FEUltNroRequest
    assert_value :FEUltNroRequest, 1, 10000000000
  end

  test :FERecuperaLastCMPRequest do
    execute :FERecuperaLastCMPRequest, "01 0001"
    assert_value :FERecuperaLastCMPRequest, 1, 1000
  end

  test :FERecuperaQTYRequest do
    execute :FERecuperaQTYRequest
    assert_value :FERecuperaQTYRequest, 250
  end

  test :FEConsultaCAERequest do
    execute :FEConsultaCAERequest, "10 20238883890 01 0001 00000001 1210.0 20110101"
    assert_value :FEConsultaCAERequest, 0
  end

  def script
    "wsfe"
  end
end
