class FriendshipsController < ApplicationController

  def new
    @current_user = current_user
    @available_user = User.find((User.all.order(:name).ids - [@current_user.id] - @current_user.friends.ids))
    @friendship = Friendship.new
  end

  def create
    friends = params[:friendship][:friend_b_id] ? params[:friendship][:friend_b_id].compact.reject {|item| item.empty? } : []
    if friends.size == 0
      redirect_to new_friendship_path, flash: {error: "You should choose your friend to first."}
    else
      @current_user = current_user
      friends.each do |f|
        friend_b = User.find f
        friendship_a  = Friendship.new
        friendship_a.friend_a = @current_user
        friendship_a.friend_b = friend_b

        friendship_b  = Friendship.new
        friendship_b.friend_b = @current_user
        friendship_b.friend_a = friend_b

        friendship_a.save
        friendship_b.save
      end
      redirect_to root_path, flash: {success: "You have added new friend(s)"}
    end

  end

  def index
  end

end
