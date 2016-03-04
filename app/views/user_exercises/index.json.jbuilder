json.array!(@user_exercises) do |user_exercise|
  json.extract! user_exercise, :id, :exercise, :day, :total
  json.url user_exercise_url(user_exercise, format: :json)
end
