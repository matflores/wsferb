require "test_helper"

Protest.describe "WSAA client" do 
  %w(wsfe wsfex).each do |service|
    it "should return a valid ticket for #{service}" do
      ticket = WSAA::Client.requestTicket(CUIT, service, CERT_FILE, KEY_FILE)

      assert ticket.valid?
    end
  end
end
