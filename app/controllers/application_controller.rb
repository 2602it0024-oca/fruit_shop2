class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

before_action :configure_permitted_parameters, if: :devise_controller?
before_action :store_recent_product

include PriceCalculations

def after_sign_in_path_for(resource)
   mypage_path(resource)
 end

 def after_sign_out_path_for(resource)
  root_path
 end

 def destroy
   session.delete(:current_user_id)
   flash[:notice] = "ログアウトしました"
   redirect_to root_url
  end

protected

 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :admin_flg ])
  end

private
def store_recent_product
  if params[:controller] == "products" && params[:action] == "show"
    product_id = params[:id].to_i
    session[:recent_product_ids] ||= []
    session[:recent_product_ids].delete(product_id)
    session[:recent_product_ids].unshift(product_id)
    session[:recent_product_ids] = session[:recent_product_ids].take(5)

  end
end
end
