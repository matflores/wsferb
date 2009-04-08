require File.dirname(__FILE__) + '/spec_helper.rb' 

Defaults = { :cuit => 20238883890, 
             :token => 'token', 
             :sign => 'sign', 
             :source => 'CN=wsaahomo, O=AFIP, C=AR, SERIALNUMBER=CUIT 33693450239',
             :destination => 'SERIALNUMBER=CUIT 20238883890, EMAILADDRESS=mflores@atlanware.com, CN=matias alejandro flores, O=matias alejandro flores, ST=buenos aires, C=ar',
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
              "    <destination>SERIALNUMBER=CUIT 20238883890, EMAILADDRESS=mflores@atlanware.com, CN=matias alejandro flores, O=matias alejandro flores, ST=buenos aires, C=ar</destination>\n" +
              "    <uniqueId>#{Time.local(2008,9,1).to_i}</uniqueId>\n" +
              "    <generationTime>2008-09-01T00:00:00-03:00</generationTime>\n" +
              "    <expirationTime>2008-10-01T00:00:00-03:00</expirationTime>\n" +
              "  </header>\n" +
              "  <credentials>\n" +
              "    <token>token</token>\n" +
              "    <sign>sign</sign>\n" +
              "  </credentials>\n" +
              "</loginTicketResponse>\n"

describe "An access ticket" do
  describe "(validations)" do
    it "should be valid if it has a cuit, a token, a sign, and it has not expired yet" do
      ticket = WSAA::Ticket.new(Defaults)
      ticket.should be_valid
    end

    it "should not be valid without a cuit" do
      ticket = WSAA::Ticket.new(Defaults.merge(:cuit => nil))
      ticket.should_not be_valid
    end

    it "should not be valid without a token" do
      ticket = WSAA::Ticket.new(Defaults.merge(:token => nil))
      ticket.should_not be_valid
    end

    it "should not be valid without a sign" do
      ticket = WSAA::Ticket.new(Defaults.merge(:sign => nil))
      ticket.should_not be_valid
    end

    it "should not be valid without an expiration date" do
      ticket = WSAA::Ticket.new(Defaults.merge(:expirationTime => nil))
      ticket.should_not be_valid
    end

    it "should not be valid if already expired" do
      ticket = WSAA::Ticket.new(Defaults.merge(:expirationTime => Time.now - 600))
      ticket.should_not be_valid
    end
  end

  it "should tell if it's expired" do
    ticket = WSAA::Ticket.new(Defaults)
    expired_ticket = WSAA::Ticket.new(Defaults.merge(:expirationTime => Time.now - 600))
    ticket.should_not be_expired
    expired_ticket.should be_expired
  end

  it "should be exportable to xml" do
    options = Defaults.merge(:generationTime => Time.local(2008,9,1), :expirationTime => Time.local(2008,10,1))
    ticket = WSAA::Ticket.new(options)
    ticket.to_xml.should == XML_response
  end

  it "should be exportable to a xml file" do
    options = Defaults.merge(:generationTime => Time.local(2008,9,1), :expirationTime => Time.local(2008,10,1))
    ticket = WSAA::Ticket.new(options)
    xml_file = File.dirname(__FILE__) + "/TA.xml"
    ticket.save(xml_file)
    f = File.new(xml_file)
    f.read().should == XML_response
    f.close
  end

  it "should be importable from valid xml" do
    ticket = WSAA::Ticket.from_xml(Defaults[:cuit],XML_response)
    ticket.should_not be_nil
    ticket.cuit.should == Defaults[:cuit]
    ticket.token.should == Defaults[:token]
    ticket.sign.should == Defaults[:sign]
    ticket.source.should == Defaults[:source]
    ticket.destination.should == Defaults[:destination]
    ticket.generationTime.should == Time.local(2008,9,1)
    ticket.expirationTime.should == Time.local(2008,10,1)
  end

  it "should be loadable from a valid xml file" do
    xml_file = File.dirname(__FILE__) + "/TA.xml"
    f = File.new(xml_file,"w")
    f.write(XML_response)
    f.close
    ticket = WSAA::Ticket.load(Defaults[:cuit],xml_file)
    ticket.should_not be_nil
    ticket.cuit.should == Defaults[:cuit]
    ticket.token.should == Defaults[:token]
    ticket.sign.should == Defaults[:sign]
    ticket.source.should == Defaults[:source]
    ticket.destination.should == Defaults[:destination]
    ticket.generationTime.should == Time.local(2008,9,1)
    ticket.expirationTime.should == Time.local(2008,10,1)
  end

end
