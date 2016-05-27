class Admin::ImpersonationsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    if @user.admin?
      flash[:impersonate] = "Can't impersonate an admin."
    else
      flash[:impersonate] = "Impersonating user #{user.id}"
      session[:actual_user_id] = session[:user_id]
      session[:user_id] = @user.id
    end
    redirect_to admin_users_path
  end

  def destroy
    session[:user_id] = session[:actual_user_id]
    session[:actual_user_id] = nil
    redirect_to admin_users_path
  end

end
