require File.dirname(__FILE__) + '/../lib/wsaaClient.rb'
require File.dirname(__FILE__) + '/../lib/wsfeClient.rb'

describe "WSFE client" do 

  describe "given a valid ticket" do
    before(:all) do
      cert_file = File.dirname(__FILE__) + "/CUIT_20238883890.crt"
      key_file = File.dirname(__FILE__) + "/CUIT_20238883890.key"
      @valid_ticket = WSAA::Client.requestTicket(20238883890, 'wsfe', cert_file, key_file)
      @valid_ticket.should be_valid
    end

    it "should return the maximum number of records to be included in the wsfe FEAutorizarRequest service" do
      response = WSFE::Client.recuperaMaxQty(@valid_ticket)
      response.value.should == 2510
      response.errCode.should == 0
      response.errMsg.should == 'OK'
    end

    it "should return the last transaction number" do
      response = WSFE::Client.recuperaUltNroTransaccion(@valid_ticket)
      response.value.should_not == 0
      response.errCode.should == 0
      response.errMsg.should == 'OK'
    end
  end

  describe "given an invalid ticket" do
    before(:all) do
      @invalid_ticket = WSAA::Ticket.new
      @invalid_ticket.should_not be_valid
    end

    it "should return an error when requesting the maximum number of records" do
      response = WSFE::Client.recuperaMaxQty(@invalid_ticket)
      response.value.should == 0
      response.errCode.should == 1000
      response.errMsg.should_not == 'OK'
    end
  end

end
