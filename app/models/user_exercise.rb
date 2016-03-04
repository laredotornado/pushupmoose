class UserExercise < ActiveRecord::Base

  validates :day, :presence => true
  validates_numericality_of :total
  validates :exercise_id, :presence => true

  def self.find_total_by_user_exercise_month_and_year(user_id, exercise, month, year) 
    sum(:total, :conditions => ['user_id = ?', user_id, 'exercise_id = ?', exercise, 'month(day) = ?', month, 'year(day) = ?', year]) 
  end

  def self.find_total_by_user_exercise_and_year(user_id, exercise, year) 
    sum(:total, :conditions => ['user_id = ?', user_id, 'exercise_id = ?', exercise, 'year(day) = ?', year]) 
  end

end
