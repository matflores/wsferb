$: << File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))

require "rubygems"
require "protest"
require "wsferb"
require "yaml"

WSFErb.enable_test_mode

def settings
  $settings ||= YAML.load_file(File.join(File.dirname(__FILE__), "settings.yml"))
end

CUIT      = settings[:cuit].to_s
CERT_FILE = File.join(File.dirname(__FILE__), "credentials", "#{CUIT}.crt")
KEY_FILE  = File.join(File.dirname(__FILE__), "credentials", "#{CUIT}.key")

unless File.exists?(CERT_FILE) && File.exists?(KEY_FILE)
  puts <<-EOS

    Falta configurar el certificado digital y/o la clave privada.

    Copiar el certificado digital X.509 otorgado por AFIP en test/credentials/#{CUIT}.crt.
    Copiar la clave privada utilizada para crear el CSR en test/credentials/#{CUIT}.key.
    El certificado digital debe estar habilitado para acceder al entono Testing.

    Si su CUIT no es "#{CUIT}", modifique el CUIT especificado en el archivo test/settings.yml
    y renombre el certificado digital y la clave privada.

  EOS
  exit 1
end

class Protest::TestCase
  def self.test_method(method, arguments = nil)
    test "Success" do
      execute method, arguments
      check_output method
    end
  end

  def execute(method, arguments = nil, credentials = credentials)
    `#{script} #{method} #{arguments} #{credentials} --ticket test/tmp/ticket_#{script}.xml --test > test/tmp/#{method}.txt`
  end

  def credentials
    "--cuit #{CUIT} --cert #{CERT_FILE} --key #{KEY_FILE}"
  end

  def check_output(method)
    fixture_file = expand_path("fixtures/#{method}.txt")
    output_file  = expand_path("tmp/#{method}.txt")

    assert_equal '', `diff #{fixture_file} #{output_file}`
    assert $?.success?, 'diff failed'
  end

  def expand_path(filename)
    File.join(File.dirname(__FILE__), filename)
  end

  def assert_value(method, min, max = min)
    response = WSFErb::Response.load(expand_path("tmp/#{method}.txt"))

    if numeric?(response.value)
      assert response.value.to_f >= min && response.value.to_f <= max, "expected [#{min == max ? min : [min, max].join('..')}] but was [#{response.value}]"
    else
      assert response.value == min, "expected [#{min}] but was [#{response.value}]"
    end
  end

  def assert_error(method, code, message)
    expected = "E%06d%s" % [ code, message ]
    actual   = File.read(expand_path("tmp/#{method}.txt")).strip

    assert_equal expected, actual
  end

  def assert_error_code(method, code)
    response = WSFErb::Response.load(expand_path("tmp/#{method}.txt"))

    assert response.has_error?(code), "expected response to have the error code [#{code}]"
  end

  def assert_success(method)
    response = WSFErb::Response.load(expand_path("tmp/#{method}.txt"))

    assert response.success?
  end

  def numeric?(value)
    true if Float(value) rescue false
  end

  def script
    "wsfe"
  end

  def self.test_common_options(service)
    describe "Common options" do
      ["-v", "--version"].each do |switch|
        test "Should display version information when #{switch} switch is present" do
          `#{script} #{switch} > test/tmp/version.txt`
          assert_equal service.version_info.strip, File.read(expand_path("tmp/version.txt")).strip
        end
      end

      ["-h", "--help"].each do |switch|
        test "Should display help information when #{switch} switch is present" do
          `#{script} #{switch} > test/tmp/help.txt`
          assert_equal service.help_info.strip, File.read(expand_path("tmp/help.txt")).strip
        end
      end
    end
  end

  def self.test_common_errors(service = nil, args = nil)
    if service
      test "Missing CUIT" do
        execute service, args, "--cert #{CERT_FILE} --key #{KEY_FILE}"
        assert_error service, 900002, "CUIT no informado"
      end

      test "Certificate not found" do
        execute service, args, "--cuit 20238883890 --cert unknown.crt --key #{KEY_FILE}"
        assert_error service, 900003, "Certificado no encontrado: #{File.expand_path('unknown.crt')}"
      end

      test "Private key not found" do
        execute service, args, "--cuit 20238883890 --cert #{CERT_FILE} --key unknown.key"
        assert_error service, 900004, "Clave privada no encontrada: #{File.expand_path('unknown.key')}"
      end

      test "Invalid output dir" do
        execute service, "#{args} --out unknown_dir/output.txt"
        assert_error service, 900006, "Directorio no valido: #{File.expand_path('unknown_dir')}"
      end

      test "Invalid log dir" do
        execute service, "#{args} --log unknown_dir/output.log"
        assert_error service, 900006, "Directorio no valido: #{File.expand_path('unknown_dir')}"
      end
    else
      describe "Common errors" do
        test "Invalid Service (blank)" do
          execute ""
          assert_error "", 900001, "Servicio no informado"
        end

        test "Invalid Service (unknown)" do
          execute :Unknown
          assert_error :Unknown, 900001, "Servicio no valido: Unknown"
        end
      end
    end
  end
end

Protest.autorun = false
Protest.report_with(:documentation)

at_exit do
  silence_warnings do
    Protest.run_all_tests!
  end
end
