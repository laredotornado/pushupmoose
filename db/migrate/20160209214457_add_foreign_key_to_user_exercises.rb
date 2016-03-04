class AddForeignKeyToUserExercises < ActiveRecord::Migration
  def change
    add_foreign_key :user_exercises, :users 
  end
end
