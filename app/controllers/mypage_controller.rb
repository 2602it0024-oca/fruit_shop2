class MypageController < ApplicationController
  before_action :authenticate_user!
  def show
     @user = current_user
  end

private

def user_params
    params.require(:user).permit(:name, :email, :admin_flg)
   end
end
