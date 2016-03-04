require 'test_helper'

class UserExercisesControllerTest < ActionController::TestCase
  setup do
    @user_exercise = user_exercises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_exercise" do
    assert_difference('UserExercise.count') do
      post :create, user_exercise: { day: @user_exercise.day, exercise: @user_exercise.exercise, total: @user_exercise.total }
    end

    assert_redirected_to user_exercise_path(assigns(:user_exercise))
  end

  test "should show user_exercise" do
    get :show, id: @user_exercise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_exercise
    assert_response :success
  end

  test "should update user_exercise" do
    patch :update, id: @user_exercise, user_exercise: { day: @user_exercise.day, exercise: @user_exercise.exercise, total: @user_exercise.total }
    assert_redirected_to user_exercise_path(assigns(:user_exercise))
  end

  test "should destroy user_exercise" do
    assert_difference('UserExercise.count', -1) do
      delete :destroy, id: @user_exercise
    end

    assert_redirected_to user_exercises_path
  end
end
