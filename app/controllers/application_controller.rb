class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :sign_in?

  def current_user
    return unless session[:user_id]
    User.find(session[:user_id])
  end

  def sign_in?
    current_user
  end

  def require_login
    redirect_to sign_in_path, flash: {error: 'You must sign in first to see this page.'} unless sign_in?
  end

  def skipped_if_login
    redirect_to messages_path(receiver_id: session[:user_id]) if sign_in?
  end
end
