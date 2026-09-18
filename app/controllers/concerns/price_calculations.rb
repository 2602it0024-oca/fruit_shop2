module PriceCalculations
  def cart_calculation
    session[:cart].each do |item|
      product = Product.find(item["id"].to_i)
      item["price"] = product.price
      item["item_price"] = calculate_item_total(item["price"], item["count"])
    end
    session[:cart_total] = calculate_total_sum(session[:cart].map { |item| item["item_price"] })
  end

  private

  def calculate_item_total(price, count)
    price.to_i * count.to_i
  end

  def calculate_total_sum(item_prices)
    item_prices.sum(&:to_i)
  end
end
