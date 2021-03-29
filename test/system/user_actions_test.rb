require "application_system_test_case"

class UserActionsTest < ApplicationSystemTestCase
  testuser = User.create(email: 'test@user.com', username: 'Test User', password: 'password')

  test "log in button visible on home page" do
    visit root_url
    assert_text "Login"
  end

  Megalith.create(name: "Stonehenge")

  test "navigating to megalith page displays mark as visited button" do
    log_in
    id = Megalith.first.id
    visit "megaliths/#{id}"
    assert_text "Mark as visited"
  end

  test "megalith page does not show rating form when not marked as visited" do
    log_in
    id = Megalith.first.id
    visit "megaliths/#{id}"
    assert has_no_selector? "#new_rating"
  end

  test "megalith page shows rating form when marked as visited" do
    log_in
    id = Megalith.first.id
    visit "megaliths/#{id}"
    find_link("Mark as visited").click
    assert has_selector? "#new_rating"
  end

  private

  def log_in
    visit 'users/sign_in'
    fill_in "user[email]", with: "test@user.com"
    fill_in "user[password]", with: "password"
    click_on "Log in"
  end
end
