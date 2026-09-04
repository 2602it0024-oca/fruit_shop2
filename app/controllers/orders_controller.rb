class OrdersController < ApplicationController
  def new
    @order = Order.new 
    @product = Product.find(params[:product_id])   
  end
  
  def index
    @orders = current_user.orders.all 
  end


  def confirm
    @order = Order.new(order_params)        
    @product = Product.find(order_params[:product_id]) 

    if @order.valid?
        @order.total_price = cal_total_price(@product.price, @order.count) # 合計金額を計算して設定
      else
      
        render :new and return
    end
  end
  
 
  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    
    
    if @order.save
      redirect_to complete_order_path(@order)     # 登録が完了したら注文完了ページへ遷移
    else
      @product = Product.find(@order.product_id)
      redirect_to new_order_path(product_id: @order.product_id)        # 注文入力へ戻る
    end
  end

  
  def complete
    @order = Order.find(params[:id])
    @product = Product.find(@order.product_id)
  end

  private
  
  def order_params
    params.require(:order).permit(:product_id, :count, :address, :total_price)
  end

  def cal_total_price(price, count)
    return price * count  
end