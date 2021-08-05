require "test_helper"

class SingUpUserTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "admin", email: "admin@example.com", password: "password", admin: true)
    @normal_user = User.create(username: "normal", email: "normal@example.com", password: "password", admin: false)
  end

  test "admin user sing up" do
    get "/login"
    assert_response :success
    sign_in_as(@admin_user)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Logged in successfully", response.body
    assert_select "a[href=?]", "#", text: "(Admin) Profile [#{@admin_user.username}]"
  end

  test "normal user sing up" do
    get "/login"
    assert_response :success
    sign_in_as(@normal_user)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Logged in successfully", response.body
    assert_select "a[href=?]", "#", text: "Profile [#{@normal_user.username}]"
  end
end
