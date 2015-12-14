class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.boolean :read
      t.date :read_at
      t.references :sender, index: true, references: :user
      t.references :receiver, index: true, references: :user

      t.timestamps null: false
    end
  end
end
