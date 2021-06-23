require "application_system_test_case"

class UserActionsTest < ApplicationSystemTestCase
  testuser = User.create(email: 'test@user.com', username: 'Test User', password: 'password')

  test "log in button visible on home page" do
    visit root_url
    assert_text "Login"
  end

  Megalith.create(name: "Menhir")

  test "navigating to megalith page displays mark as visited button" do
    log_in
    megalith = Megalith.find_by_name "Menhir"
    visit megalith_path(megalith)
    assert_text "Mark as visited"
  end

  test "megalith page does not show rating form when not marked as visited" do
    log_in
    megalith = Megalith.find_by_name "Menhir"
    visit megalith_path(megalith)
    assert has_no_selector? "#new_rating"
  end

  test "megalith page shows rating form when marked as visited" do
    log_in
    megalith = Megalith.find_by_name "Menhir"
    visit megalith_path(megalith)
    find_link("Mark as visited")&.click
    assert has_selector? "#new_rating"
  end

  private

  def log_in
    visit new_user_session_path
    fill_in "user[email]", with: "test@user.com"
    fill_in "user[password]", with: "password"
    click_on "Log in"
  end
end
