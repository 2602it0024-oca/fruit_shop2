class UserCartsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_cart_item, only: [:update_item, :destroy_item]

  def show
    @cart_items = current_user.cart_items.includes(:product)
    @total_price = @cart_items.sum { |item| item.product.price * item.quantity }
  end

  def add_item
    product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i

    if product.blank? || quantity <= 0
      redirect_to products_path, alert: "不正なカート操作です。"
      return
    end

    cart_item = current_user.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity += quantity if cart_item.persisted?
    cart_item.quantity = quantity unless cart_item.persisted?

    if cart_item.save
      redirect_to user_cart_path, notice: "商品がカートに追加されました。"
    else
      redirect_to product_path(product), alert: "カートへの追加に失敗しました。"
    end
  end

  def update_item
    new_quantity = @cart_item.quantity + params[:delta].to_i
    if new_quantity <= 0
      @cart_item.destroy
      redirect_to user_cart_path, notice: "商品をカートから削除しました。"
      return
    end

    if @cart_item.update(quantity: new_quantity)
      redirect_to user_cart_path
    else
      redirect_to user_cart_path, alert: "数量を更新できませんでした。"
    end
  end

  def destroy_item
    @cart_item.destroy
    redirect_to user_cart_path, notice: "商品をカートから削除しました。"
  end

  private

  def load_cart_item
    @cart_item = current_user.cart_items.find_by(id: params[:id])
    return if @cart_item.present?

    redirect_to user_cart_path, alert: "対象の商品が見つかりません。"
  end
end
