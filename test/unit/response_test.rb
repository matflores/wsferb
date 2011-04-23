require "test_helper"

Protest.describe "A response" do
  it "should be successful if there were no errors" do
    response = Response.new

    assert response.success?
  end

  it "should not be successful if there was at least one error reported" do
    response = Response.new
    response.add_error(1000, "Not authorized")

    assert !response.success?
  end

  it "should include error code and error message in the string representation" do
    response = Response.new
    response.add_error(1000, "Not authorized")

    assert_equal "E001000Not authorized", response.to_s
  end

  it "should keep the error count" do
    response = Response.new
    3.times { response.add_error(1000, "Not authorized") }

    assert_equal 3, response.errors.count
  end

  it "should include event code and event message in the string representation" do
    response = Response.new
    response.add_event(1000, "An event occurred")

    assert_equal "V001000An event occurred", response.to_s
  end

  it "should keep the event count" do
    response = Response.new
    3.times { response.add_event(1000, "An event occurred") }

    assert_equal 3, response.events.count
  end

  it "should include both errors and events in the string representation" do
    response = Response.new
    3.times { response.add_error(1000, "Not authorized") }
    3.times { response.add_event(1000, "An event occurred") }

    assert_equal "E001000Not authorized\nE001000Not authorized\nE001000Not authorized\n" +
                 "V001000An event occurred\nV001000An event occurred\nV001000An event occurred", response.to_s
  end

  it "should know if a specific error code has occurred" do
    response = Response.new
    response.add_error(1000, "Not authorized")

    assert response.has_error?(1000)
    assert !response.has_error?(1001)
  end

  it "should know if a specific event code has occurred" do
    response = Response.new
    response.add_event(1000, "An event has occurred")

    assert response.has_event?(1000)
    assert !response.has_event?(1001)
  end
end
