$: << File.expand_path(File.dirname(__FILE__) + "/../src/lib")

require 'rubygems'
require 'protest'
require 'silence'
require 'wsaa'
require 'wsfe'
require 'wsfex'

WSAA::Client.enable_test_mode
WSFE::Client.enable_test_mode
WSFEX::Client.enable_test_mode

CERT_FILE = File.join File.dirname(__FILE__), 'credentials', '20238883890.crt'
KEY_FILE  = File.join File.dirname(__FILE__), 'credentials', '20238883890.key'

Protest.autorun = false
Protest.report_with(:documentation)

class Protest::TestCase
  def self.test_method(method, arguments = nil)
    test method do
      execute method, arguments
      check_output method
    end
  end

  def execute(method, arguments = nil, credentials = credentials)
    `#{script} #{method} #{arguments} #{credentials} --ticket test/tmp/ticket.xml --test > test/output/#{method}.txt`
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
    File.join(File.dirname(__FILE__), filename)
  end

  def assert_value(method, min, max = nil)
    max ||= min

    response = parseResponse(method)

    if numeric?(response.value)
      assert response.value.to_f >= min && response.value.to_f <= max, "expected [#{min == max ? min : [min, max].join('..')}] but was [#{response.value}]"
    else
      assert response.value == min, "expected [#{min}] but was [#{response.value}]"
    end
  end

  def assert_error(method, code, message)
    assert_error_code(method, code)
    assert_error_message(method, message)
  end

  def assert_error_code(method, value)
    response = parseResponse(method)

    assert response.errCode.to_s == value.to_s, "expected [#{value}] but was [#{response.errCode}]"
  end

  def assert_error_message(method, value)
    response = parseResponse(method)

    case value
    when Regexp
      match = response.errMsg.to_s =~ value
    else
      match = response.errMsg.to_s == value.to_s
    end

    assert match, "expected [#{value}] but was [#{response.errMsg}]"
  end

  def assert_success(method)
    assert_error_code(method, 0)
  end

  def parseResponse(method)
    output = File.read(expand_path("output/#{method}.txt"))
    AFIP::Response.parse(output)
  end

  def numeric?(value)
    true if Float(value) rescue false
  end

  def script
    "wsfe"
  end
end

at_exit do
  silence_warnings do
    Protest.run_all_tests!
  end
end
