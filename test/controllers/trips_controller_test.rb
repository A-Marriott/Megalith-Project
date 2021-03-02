require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get trips_edit_url
    assert_response :success
  end

end
