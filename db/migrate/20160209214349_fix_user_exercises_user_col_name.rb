class FixUserExercisesUserColName < ActiveRecord::Migration
  def change
    rename_column :user_exercises, :user, :user_id 
  end
end
