require "test_helper"

Protest.describe "WSFEX" do
  describe "FEXDummy" do
    test_method :FEXDummy
  end

  describe "FEXCheckPermiso" do
    test "Success" do
      execute :FEXCheckPermiso, "11111 310"
      assert_value :FEXCheckPermiso, "OK"
    end

    test_common_errors(:FEXCheckPermiso, "11111 310")
  end

  describe "FEXGetLastCmp" do
    test "Success" do
      execute :FEXGetLastCmp, "19 0001"
      assert_value :FEXGetLastCmp, 1, 1000
    end

    test_common_errors(:FEXGetLastCmp, "19 0001")
  end

  describe "FEXGetLastId" do
    test "Success" do
      execute :FEXGetLastId
      assert_value :FEXGetLastId, 1, 10000000000
    end

    test_common_errors(:FEXGetLastId)
  end

  describe "FEXGetParamCtz" do
    test "Success" do
      execute :FEXGetParamCtz, "DOL"
      assert_value :FEXGetParamCtz, 3.5, 4.5
    end

    test_common_errors(:FEXGetParamCtz, "DOL")
  end

  [ :FEXGetParamDstCuit,
    :FEXGetParamDstPais,
    :FEXGetParamIdiomas,
    :FEXGetParamIncoterms,
    :FEXGetParamMon,
    :FEXGetParamPtoVenta,
    :FEXGetParamTipoCbte,
    :FEXGetParamTipoExpo,
    :FEXGetParamUMed ].each do |service|

    describe(service.to_s) do
      test_method(service)
      test_common_errors(service)
    end

  end

  test_common_options(WSFErb::WSFEX)
  test_common_errors

  def script
    "wsfex"
  end
end
