require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get hello" do
    get homes_hello_url
    assert_response :success
  end

end
