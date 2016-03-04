class CreateUserExercises < ActiveRecord::Migration
  def change
    create_table :user_exercises do |t|
      t.string :user
      t.string :exercise
      t.date :day
      t.integer :total

      t.timestamps null: false
    end
  end
end
