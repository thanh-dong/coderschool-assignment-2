class UsersController < ApplicationController

  before_action :require_login, only: [:index]
  before_action :skipped_if_login, only: [:new]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path , flash: {success: "Welcome #{@user.name}"}
    else
      redirect_to root_path, flash: {error: "Something goes wrong. Oops!"}
    end

  end

  def add_friends
    @available_user = User.all.order(:name)
    @current_user = current_user
    render 'add_friends'
  end

  def do_add_friends
    friend_list = params[:user][:friends].reject { |item| item.empty? }
    params.require(:user).permit(:friends)
    @current_user = current_user
    friend_list.each do |friend_id|
      friend = User.find friend_id
      @current_user.friends << friend
      friend.friends << @current_user
      friend.save
    end
    @current_user.save
    redirect_to root_path, flash: {success: "You have added new friends."}
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :password)
    end
end
