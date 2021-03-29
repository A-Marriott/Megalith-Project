require "application_system_test_case"

class UserActionsTest < ApplicationSystemTestCase
  testuser = User.create(email: 'test@user.com', username: 'Test User', password: 'password')
  test "log in button visible on home page" do
    visit root_url
    assert_text "Login"
  end

end
