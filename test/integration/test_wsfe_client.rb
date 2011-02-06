require 'test_helper'

class Protest::TestCase
  def self.test_method(method, arguments = nil, send_credentials = true)
    test method do
      execute method, arguments, send_credentials
      check_output method
    end
  end
end

Protest.describe "WSFE" do
  test_method :FEDummy, '', false

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

  describe "FEAutRequest" do
    before do

    end
    it "success" do
    end
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
