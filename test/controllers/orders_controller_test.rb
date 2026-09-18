require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_order_url(product_id: products(:one).id)
    assert_response :success
  end
end
