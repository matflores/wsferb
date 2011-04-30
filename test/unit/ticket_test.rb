require "test_helper"

Defaults = { :cuit => CUIT, 
             :token => 'token', 
             :sign => 'sign', 
             :source => 'CN=wsaahomo, O=AFIP, C=AR, SERIALNUMBER=CUIT 33693450239',
             :destination => "SERIALNUMBER=CUIT #{CUIT}, EMAILADDRESS=mflores@atlanware.com, CN=matias alejandro flores, O=matias alejandro flores, ST=buenos aires, C=ar",
             :generationTime => Time.now,
             :expirationTime => Time.now + 600 }

XML_request = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + 
               "<loginTicketRequest version=\"1.0\">\n" +
               "  <header>\n" +
               "    <uniqueId>#{Time.local(2008,9,1).to_i}</uniqueId>\n" +
               "    <generationTime>2008-09-01T00:00:00-03:00</generationTime>\n" +
               "    <expirationTime>2008-10-01T00:00:00-03:00</expirationTime>\n" +
               "  </header>\n" +
               "  <service>wsfe</service>\n" +
               "</loginTicketRequest>\n"

XML_response = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" + 
              "<loginTicketResponse version=\"1\">\n" +
              "  <header>\n" +
              "    <source>CN=wsaahomo, O=AFIP, C=AR, SERIALNUMBER=CUIT 33693450239</source>\n" +
              "    <destination>SERIALNUMBER=CUIT #{CUIT}, EMAILADDRESS=mflores@atlanware.com, CN=matias alejandro flores, O=matias alejandro flores, ST=buenos aires, C=ar</destination>\n" +
              "    <uniqueId>#{Time.local(2008,9,1).to_i}</uniqueId>\n" +
              "    <generationTime>2008-09-01T00:00:00-03:00</generationTime>\n" +
              "    <expirationTime>2008-10-01T00:00:00-03:00</expirationTime>\n" +
              "  </header>\n" +
              "  <credentials>\n" +
              "    <token>token</token>\n" +
              "    <sign>sign</sign>\n" +
              "  </credentials>\n" +
              "</loginTicketResponse>\n"

AUTH_HASH = { :Auth => { :Token => "token", :Sign  => "sign", :Cuit  => CUIT } }

Protest.describe "An access ticket" do
  describe "(validations)" do
    it "is valid if it has a cuit, a token, a sign, and it has not expired yet" do
      ticket = WSFErb::Ticket.new(Defaults)
      assert ticket.valid?
    end

    it "is not valid without a cuit" do
      ticket = WSFErb::Ticket.new(Defaults.merge(:cuit => nil))
      assert !ticket.valid?
    end

    it "is not valid without a token" do
      ticket = WSFErb::Ticket.new(Defaults.merge(:token => nil))
      assert !ticket.valid?
    end

    it "is not valid without a sign" do
      ticket = WSFErb::Ticket.new(Defaults.merge(:sign => nil))
      assert !ticket.valid?
    end

    it "is not valid without an expiration date" do
      ticket = WSFErb::Ticket.new(Defaults.merge(:expirationTime => nil))
      assert !ticket.valid?
    end

    it "is not valid if already expired" do
      ticket = WSFErb::Ticket.new(Defaults.merge(:expirationTime => Time.now - 600))
      assert !ticket.valid?
    end
  end

  it "knows if it's already expired" do
    ticket = WSFErb::Ticket.new(Defaults)
    expired_ticket = WSFErb::Ticket.new(Defaults.merge(:expirationTime => Time.now - 600))

    assert !ticket.expired?
    assert expired_ticket.expired?
  end

  it "can be exported to xml" do
    options = Defaults.merge(:generationTime => Time.local(2008,9,1), :expirationTime => Time.local(2008,10,1))
    ticket = WSFErb::Ticket.new(options)

    assert_equal XML_response, ticket.to_xml
  end

  it "can be exported to an xml file" do
    options = Defaults.merge(:generationTime => Time.local(2008,9,1), :expirationTime => Time.local(2008,10,1))
    ticket = WSFErb::Ticket.new(options)
    xml_file = Tempfile.new("ticket")
    ticket.save(xml_file.path)

    assert_equal XML_response, File.read(xml_file.path)
  end

  it "can be imported from valid xml" do
    ticket = WSFErb::Ticket.from_xml(Defaults[:cuit], XML_response)

    assert !ticket.nil?
    assert_equal Defaults[:cuit]       , ticket.cuit
    assert_equal Defaults[:token]      , ticket.token
    assert_equal Defaults[:sign]       , ticket.sign
    assert_equal Defaults[:source]     , ticket.source
    assert_equal Defaults[:destination], ticket.destination
    assert_equal Time.local(2008,9,1)  , ticket.generationTime
    assert_equal Time.local(2008,10,1) , ticket.expirationTime
  end

  it "can be loaded from a valid xml file" do
    xml_file = Tempfile.new("ticket")
    xml_file.write(XML_response)
    xml_file.close

    ticket = WSFErb::Ticket.load(Defaults[:cuit], xml_file.path)

    assert !ticket.nil?
    assert_equal Defaults[:cuit]       , ticket.cuit
    assert_equal Defaults[:token]      , ticket.token
    assert_equal Defaults[:sign]       , ticket.sign
    assert_equal Defaults[:source]     , ticket.source
    assert_equal Defaults[:destination], ticket.destination
    assert_equal Time.local(2008,9,1)  , ticket.generationTime
    assert_equal Time.local(2008,10,1) , ticket.expirationTime
  end

  it "can be exported as a hash" do
    options = Defaults.merge(:generationTime => Time.local(2008,9,1), :expirationTime => Time.local(2008,10,1))
    ticket = WSFErb::Ticket.new(options)

    assert_equal AUTH_HASH, ticket.to_hash
  end
end
