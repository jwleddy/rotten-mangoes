class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def only_admins
    redirect_to root_path unless admin?
  end

  def admin?
    current_user && (current_user.admin? || impersonating?)
  end

  def impersonating?
    if session[:actual_user_id].present?
      user = User.find(session[:actual_user_id])
      user.admin?
    else
      false
    end
  end

  helper_method :current_user, :admin?, :impersonating?

end
