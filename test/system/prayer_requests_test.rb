require "application_system_test_case"

class PrayerRequestsTest < ApplicationSystemTestCase
  setup do
    @prayer_request = prayer_requests(:one)
  end

  test "visiting the index" do
    visit prayer_requests_url
    assert_selector "h1", text: "Prayer requests"
  end

  test "should create prayer request" do
    visit prayer_requests_url
    click_on "New prayer request"

    fill_in "Account", with: @prayer_request.account_id
    fill_in "Description", with: @prayer_request.description
    fill_in "Saves count", with: @prayer_request.saves_count
    fill_in "Title", with: @prayer_request.title
    click_on "Create Prayer request"

    assert_text "Prayer request was successfully created"
    click_on "Back"
  end

  test "should update Prayer request" do
    visit prayer_request_url(@prayer_request)
    click_on "Edit this prayer request", match: :first

    fill_in "Account", with: @prayer_request.account_id
    fill_in "Description", with: @prayer_request.description
    fill_in "Saves count", with: @prayer_request.saves_count
    fill_in "Title", with: @prayer_request.title
    click_on "Update Prayer request"

    assert_text "Prayer request was successfully updated"
    click_on "Back"
  end

  test "should destroy Prayer request" do
    visit prayer_request_url(@prayer_request)
    click_on "Destroy this prayer request", match: :first

    assert_text "Prayer request was successfully destroyed"
  end
end
