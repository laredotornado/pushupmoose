class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :user_exercises, :user, :integer 
  end
end
