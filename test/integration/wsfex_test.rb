require "test_helper"

Protest.describe "WSFEX" do
  test_method :FEXDummy
  test_method :FEXGetParamMon
  test_method :FEXGetParamTipoCbte
  test_method :FEXGetParamTipoExpo
  test_method :FEXGetParamUMed
  test_method :FEXGetParamIdiomas
  test_method :FEXGetParamDstPais
  test_method :FEXGetParamDstCuit
  test_method :FEXGetParamIncoterms
  test_method :FEXGetParamPtoVenta

  test :FEXGetParamCtz do
    execute :FEXGetParamCtz, "DOL"
    assert_value :FEXGetParamCtz, 3.5, 4.5
  end

  test :FEXGetLastCmp do
    execute :FEXGetLastCmp, "19 0001"
    assert_value :FEXGetLastCmp, 1, 1000
  end

  test :FEXGetLastId do
    execute :FEXGetLastId
    assert_value :FEXGetLastId, 1, 10000000000
  end

  test :FEXCheckPermiso do
    execute :FEXCheckPermiso, "11111 310"
    assert_value :FEXCheckPermiso, "OK"
  end

  def script
    "wsfex"
  end
end
