require 'test_helper'

Protest.describe "A response" do
  it "should be successful if the error code is 0" do
    response = AFIP::Response.new
    response.errCode = 0

    assert response.success?
  end

  it "should not be successful if error code is different than 0" do
    response = AFIP::Response.new
    response.errCode = 1000

    assert !response.success?
  end

  it "should include value, error code and error message in the string representation" do
    response = AFIP::Response.new
    response.value   = 0
    response.errCode = 1000
    response.errMsg  = "Not authorized"

    assert_equal "[Respuesta]\nvalor=0\nerrCode=1000\nerrMsg=Not authorized", response.to_s
  end
end
