require 'test_helper'

class Protest::TestCase
  def self.test_method(method, arguments = nil, send_credentials = true)
    test method do
      execute method, arguments, send_credentials
      check_output method
    end
  end
end

Protest.describe "WSFEX" do
  test_method :FEXDummy, '', false

  test_method :FEXGetParamMon
  test_method :FEXGetParamTipoCbte
  test_method :FEXGetParamTipoExpo
  test_method :FEXGetParamUMed
  test_method :FEXGetParamIdiomas
  test_method :FEXGetParamDstPais
  test_method :FEXGetParamDstCuit
  test_method :FEXGetParamIncoterms
  test_method :FEXGetParamPtoVenta

  test :FEXGetLastId do
    execute :FEXGetLastId
    assert_value :FEXGetLastId, 1, 10000000000
  end

  test :FEXGetParamCtz do
    execute :FEXGetParamCtz, "DOL"
    assert_value :FEXGetParamCtz, 3.5, 4.5
  end

  test :FEXCheckPermiso do
    execute :FEXCheckPermiso, "11111 310"
    assert_value :FEXCheckPermiso, "OK"
  end

  def execute(method, arguments = nil, send_credentials = true)
    `wsfe #{method} #{arguments} #{credentials if send_credentials} --test > test/output/#{method}.txt`
  end

  def credentials
    "--cuit 20238883890 --cert test/credentials/20238883890.crt --key test/credentials/20238883890.key"
  end

  def check_output(method)
    sample_file = expand_path("samples/#{method}.txt")
    output_file = expand_path("output/#{method}.txt")

    assert_equal '', `diff #{sample_file} #{output_file}`
    assert $?.success?, 'diff failed'
  end

  def expand_path(filename)
    File.join(File.dirname(__FILE__), '..', filename)
  end

  def assert_value(method, min, max = nil)
    max ||= min

    output = File.read(expand_path("output/#{method}.txt"))
    response = AFIP::Response.parse(output)

    if numeric?(response.value)
      assert response.value.to_f >= min && response.value.to_f <= max, "wrong value (#{response.value})"
    else
      assert response.value == min, "wrong value (#{response.value})"
    end
  end

  def numeric?(value)
    true if Float(value) rescue false
  end
end
