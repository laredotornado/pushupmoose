class AddIndex < ActiveRecord::Migration
  def change
    add_index :user_exercises, [:user, :day, :exercise], unique: true 
  end
end
