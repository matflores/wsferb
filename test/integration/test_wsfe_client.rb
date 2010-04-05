require 'test_helper'

Protest.describe "WSFE client" do
  it "can test if all systems are ok" do
    assert_equal "authserver=OK; appserver=OK; dbserver=OK;", WSFE::Client.test
  end

  describe "given a valid ticket" do
    before do
      cert_file = File.dirname(__FILE__) + "/../credentials/20238883890.crt"
      key_file = File.dirname(__FILE__) + "/../credentials/20238883890.key"
      @valid_ticket = WSAA::Client.requestTicket(20238883890, 'wsfe', cert_file, key_file)

      assert @valid_ticket.valid?
    end

    it "returns the maximum number of records to be included in the wsfe FEAutorizarRequest service" do
      response = WSFE::Client.recuperaMaxQty(@valid_ticket)
      assert_equal 250, response.value
      assert_equal 0, response.errCode
      assert_equal 'OK', response.errMsg
    end

    it "returns the last transaction number" do
      response = WSFE::Client.recuperaUltNroTransaccion(@valid_ticket)

      assert_not_equal 0, response.value
      assert_equal 0, response.errCode
      assert_equal 'OK', response.errMsg
    end
  end

  describe "given an invalid ticket" do
    before do
      @invalid_ticket = WSAA::Ticket.new(:cuit => 20238883890)
      assert !@invalid_ticket.valid?
    end

    it "returns an error when requesting the maximum number of records" do
      response = WSFE::Client.recuperaMaxQty(@invalid_ticket)

      assert_equal 1000, response.errCode
      assert_not_equal 'OK', response.errMsg
    end
  end
end
