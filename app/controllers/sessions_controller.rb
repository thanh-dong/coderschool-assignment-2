class SessionsController < ApplicationController

  before_action :skipped_if_login, only: [:new]

  def new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by_email(email)

    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect_to messages_path(receiver_id: user.id), flash: {success: "Welcome #{user.name}"}
    else
      redirect_to sign_in_path, flash: {error: "Email or password is incorrect. Please try again!"}
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
