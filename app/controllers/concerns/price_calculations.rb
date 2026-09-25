module PriceCalculations
  def cart_calculation
    session[:cart].each do |item|
      product = Product.find(item["id"].to_i)
      item["price"] = product.price
      item["item_price"] = calculate_item_total(item["price"], item["count"])
    end
    session[:cart_total] = calculate_total_sum(session[:cart].map { |item| item["item_price"] })
  end

def user_cart_calculation
    cart = Cart.find_by(user_id: current_user.id)
    @item_totals = cart.cart_items.map { |item| calculate_item_total(item.product.price, item.quantity) }
    @cart_total = calculate_total_sum(@item_totals)
  end

  private

  def calculate_item_total(price, count)
    price.to_i * count.to_i
  end

  def calculate_total_sum(item_prices)
    item_prices.sum(&:to_i)
  end
end
