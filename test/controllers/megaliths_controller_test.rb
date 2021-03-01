require 'test_helper'

class MegalithsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get megaliths_index_url
    assert_response :success
  end

  test "should get show" do
    get megaliths_show_url
    assert_response :success
  end

  test "should get new" do
    get megaliths_new_url
    assert_response :success
  end

end
