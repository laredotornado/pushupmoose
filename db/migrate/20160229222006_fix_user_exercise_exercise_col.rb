class FixUserExerciseExerciseCol < ActiveRecord::Migration
  def change
    change_column_null :user_exercises, :exercise, false 
    change_column :user_exercises, :exercise, :integer 
    rename_column :user_exercises, :exercise, :exercise_id
    add_foreign_key :user_exercises, :exercises 
  end
end
