class ProductsController < ApplicationController
  before_action :check_admin, except: [:index, :show]
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
       redirect_to product_path 
     else
       render :edit 
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

  def check_admin
       unless current_user.admin_flg
         redirect_to products_path, alert: '管理者権限が必要です。'
       end
      end
     
end