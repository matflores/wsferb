require File.dirname(__FILE__) + '/spec_helper.rb' 

describe "WSAA client" do 
  it "should return a valid ticket for wsfe" do
    cert_file = File.dirname(__FILE__) + "/credentials/20238883890.crt"
    key_file = File.dirname(__FILE__) + "/credentials/20238883890.key"
    ticket = WSAA::Client.requestTicket(20238883890, 'wsfe', cert_file, key_file)
    ticket.should be_valid
  end
end
