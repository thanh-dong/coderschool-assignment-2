class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :friend_a, index: true, references: :user
      t.references :friend_b, index: true, references: :user

      t.timestamps null: false
    end
  end
end
