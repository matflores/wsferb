require 'test_helper'

Protest.describe "A response" do
  it "should be successful if there were no errors" do
    response = AFIP::Response.new

    assert response.success?
  end

  it "should not be successful if there was at least one error reported" do
    response = AFIP::Response.new
    response.add_error(1000, "Not authorized")

    assert !response.success?
  end

  it "should include error code and error message in the string representation" do
    response = AFIP::Response.new
    response.add_error(1000, "Not authorized")

    assert_equal "E001000Not authorized", response.to_s
  end
end
