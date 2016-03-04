class AddDayNotNullConstraint < ActiveRecord::Migration
  def change
    change_column_null :user_exercises, :day, false 
  end
end
