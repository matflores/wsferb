require 'test_helper'

Protest.describe "WSAA client" do 
  it "should return a valid ticket for wsfe" do
    ticket = WSAA::Client.requestTicket(20238883890, 'wsfe', CERT_FILE, KEY_FILE)

    assert ticket.valid?
  end
end
