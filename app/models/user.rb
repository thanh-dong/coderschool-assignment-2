class User < ActiveRecord::Base
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :messages, :class_name => 'Message', :foreign_key => 'receiver_id'

  has_many :friendships, :class_name => 'Friendship',  :foreign_key => 'friend_a_id'
  has_many :friends, through: :friendships, source: :friend_b
  has_secure_password

end
