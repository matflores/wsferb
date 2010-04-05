require 'test_helper'

Protest.describe "WSFEX client" do
  it "can test if all systems are ok" do
    assert_equal "authserver=OK; appserver=OK; dbserver=OK;", WSFEX::Client.test
  end
end
