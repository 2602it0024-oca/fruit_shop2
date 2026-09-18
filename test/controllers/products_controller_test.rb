require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    sign_in users(:one)
    get new_product_url
    assert_response :success
  end
end
