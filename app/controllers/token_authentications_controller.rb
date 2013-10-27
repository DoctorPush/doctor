class TokenAuthenticationsController < ApplicationController

  def create
    @user = AdminUser.find(params[:admin_user_id])
    @user.reset_authentication_token!
    redirect_to appointments_path
  end

  def destroy
    @user = AdminUser.find(params[:id])
    @user.authentication_token = nil
    @user.save
    redirect_to appointments_path
  end

end
