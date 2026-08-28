class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
   end
  end
 
 def show
     @product = Product.find(params[:id])
 end

 def index
    @products = Product.all
 end

 def edit
    @product = Product.find(params[:id])
 end

  def update
    @product = Product.find(params[:id])
     if @product.update(product_params)
       redirect_to product_path # 商品詳細にリダイレクト
     else
       render :edit  # 失敗時に編集画面に戻る
     end
   end

def destroy
     @product = Product.find(params[:id])
     @product.destroy
     redirect_to products_path 
   end

 private
  def product_params
   params.require(:product).permit(:name, :description, :price)
  end
end