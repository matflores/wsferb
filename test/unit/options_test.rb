require "test_helper"

Protest.describe "An options object" do
  it "should take the service name as its first argument" do
    options = WSFErb::Options.parse(["FECAESolicitar", "--cuit", "20238883890"])

    assert_equal "FECAESolicitar", options.service
  end

  it "should take the service name as its first non-option argument" do
    options = WSFErb::Options.parse(["--cuit", "20238883890", "FECAESolicitar"])

    assert_equal "FECAESolicitar", options.service
  end

  it "should accept a CUIT with the --cuit option" do
    options = WSFErb::Options.parse(["--cuit", "20238883890"])

    assert_equal "20238883890", options.cuit
  end

  it "should accept a CUIT with the -c option" do
    options = WSFErb::Options.parse(["-c", "20238883890"])

    assert_equal "20238883890", options.cuit
  end

  it "should accept a certificate file with the --cert option" do
    options = WSFErb::Options.parse(["--cert", "mycert.crt"])

    assert_equal File.expand_path("mycert.crt"), options.cert
  end

  it "should accept a certificate file with the -r option" do
    options = WSFErb::Options.parse(["-r", "mycert.crt"])

    assert_equal File.expand_path("mycert.crt"), options.cert
  end

  it "should accept a private key file with the --key option" do
    options = WSFErb::Options.parse(["--key", "mykey.key"])

    assert_equal File.expand_path("mykey.key"), options.key
  end

  it "should accept a private key file with the -k option" do
    options = WSFErb::Options.parse(["-k", "mykey.key"])

    assert_equal File.expand_path("mykey.key"), options.key
  end

  it "should accept a ticket file with the --ticket option" do
    options = WSFErb::Options.parse(["--ticket", "myticket.xml"])

    assert_equal File.expand_path("myticket.xml"), options.ticket
  end

  it "should accept a ticket file with the -t option" do
    options = WSFErb::Options.parse(["-t", "myticket.xml"])

    assert_equal File.expand_path("myticket.xml"), options.ticket
  end

  it "should accept an output file with the --out option" do
    options = WSFErb::Options.parse(["--out", "output.txt"])

    assert_equal File.expand_path("output.txt"), options.out
  end

  it "should accept an output file with the -o option" do
    options = WSFErb::Options.parse(["-o", "output.txt"])

    assert_equal File.expand_path("output.txt"), options.out
  end

  it "should accept a log file with the --log option" do
    options = WSFErb::Options.parse(["--log", "output.log"])

    assert_equal File.expand_path("output.log"), options.log
  end

  it "should accept a log file with the -l option" do
    options = WSFErb::Options.parse(["-l", "output.log"])

    assert_equal File.expand_path("output.log"), options.log
  end

  it "should enable test mode with the --test option" do
    options = WSFErb::Options.parse(["--test"])

    assert options.test?
  end

  it "should enable test mode with the -e option" do
    options = WSFErb::Options.parse(["-e"])

    assert options.test?
  end

  it "should enable help switch with the --help option" do
    options = WSFErb::Options.parse(["--help"])

    assert options.help?
  end

  it "should enable help switch with the -h option" do
    options = WSFErb::Options.parse(["-h"])

    assert options.help?
  end

  it "should enable version switch with the --version option" do
    options = WSFErb::Options.parse(["--version"])

    assert options.version?
  end

  it "should enable version switch with the -v option" do
    options = WSFErb::Options.parse(["-v"])

    assert options.version?
  end

  it "should use ./<cuit>.crt as the default certificate file" do
    options = WSFErb::Options.parse(["--cuit", "20238883890"])

    assert_equal File.expand_path("20238883890.crt"), options.cert
  end

  it "should use ./<cuit>.key as the default primary key file" do
    options = WSFErb::Options.parse(["--cuit", "20238883890"])

    assert_equal File.expand_path("20238883890.key"), options.key
  end

  it "should run in production mode by default" do
    options = WSFErb::Options.parse()

    assert !options.test?
  end

  it "should accept a combination of multiple arguments and options" do
    options = WSFErb::Options.parse(["FECAESolicitar", "--cuit", "20238883890", "--cert", "mycert.crt", "--key", "mykey.key", "--ticket", "myticket.xml", "--out", "output.txt", "--log", "output.log", "--test"])

    assert_equal "FECAESolicitar", options.service
    assert_equal "20238883890", options.cuit
    assert_equal File.expand_path("mycert.crt"), options.cert
    assert_equal File.expand_path("mykey.key"), options.key
    assert_equal File.expand_path("myticket.xml"), options.ticket
    assert_equal File.expand_path("output.txt"), options.out
    assert_equal File.expand_path("output.log"), options.log
    assert options.test?
  end

  it "should accept an existing options object instead of an array of arguments" do
    options = WSFErb::Options.parse(["FECAESolicitar", "--cuit", "20238883890", "--cert", "mycert.crt", "--key", "mykey.key", "--ticket", "myticket.xml", "--out", "output.txt", "--log", "output.log", "--test"])

    assert_equal options, WSFErb::Options.parse(options)
  end
end
