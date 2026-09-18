require "test_helper"

class MypageControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    sign_in users(:one)
    get mypage_show_url
    assert_response :success
  end
end
