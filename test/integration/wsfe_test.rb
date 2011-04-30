require "test_helper"

Protest.describe "WSFE" do
  describe "FEDummy" do
    test_method :FEDummy
  end

  def self.test_common_errors(service)
    test "Missing CUIT" do
      execute service, nil, "--cert #{CERT_FILE} --key #{KEY_FILE}"
      assert_error service, 900002, "CUIT no informado"
    end

    test "Certificate not found" do
      execute service, nil, "--cuit 20238883890 --cert unknown.crt --key #{KEY_FILE}"
      assert_error service, 900003, "Certificado no encontrado: #{File.expand_path('unknown.crt')}"
    end

    test "Private key not found" do
      execute service, nil, "--cuit 20238883890 --cert #{CERT_FILE} --key unknown.key"
      assert_error service, 900004, "Clave privada no encontrada: #{File.expand_path('unknown.key')}"
    end

    test "Invalid output dir" do
      execute service, "--out unknown_dir/output.txt"
      assert_error service, 900006, "Directorio no valido: #{File.expand_path('unknown_dir')}"
    end

    test "Invalid log dir" do
      execute service, "--log unknown_dir/output.log"
      assert_error service, 900006, "Directorio no valido: #{File.expand_path('unknown_dir')}"
    end
  end

  describe "FECompUltimoAutorizado" do
    test "Success" do
      execute :FECompUltimoAutorizado, "01 0001"
      assert_value :FECompUltimoAutorizado, 1, 1000
    end

    test_common_errors(:FECompUltimoAutorizado)
  end

  describe "FECompTotXRequest" do
    test "Success" do
      execute :FECompTotXRequest
      assert_value :FECompTotXRequest, 250
    end

    test_common_errors(:FECompTotXRequest)
  end

  #[ :FECAEAConsultar, :FECAEARegInformativo, :FECAEASinMovimientoConsultar, :FECAEASinMovimientoInformar,
  #  :FECAEASolicitar, :FECAESolicitar, :FECompConsultar, :FECompTotXRequest, :FECompUltimoAutorizado, :FEParamGetCotizacion,
  [ :FEParamGetPtosVenta, :FEParamGetTiposCbte, :FEParamGetTiposConcepto,
    :FEParamGetTiposDoc, :FEParamGetTiposIva, :FEParamGetTiposMonedas, :FEParamGetTiposOpcional,
    :FEParamGetTiposTributos ].each do |service|

    describe(service.to_s) do
      test_method(service)
      test_common_errors(service)
    end
  end

  describe "common errors" do
    test "Invalid Service (blank)" do
      execute ""
      assert_error "", 900001, "Servicio no informado"
    end

    test "Invalid Service (unknown)" do
      execute :FEUnknown
      assert_error :FEUnknown, 900001, "Servicio no valido: FEUnknown"
    end
  end

  def script
    "wsfe"
  end
end
