class UserExercisesController < ApplicationController
  before_action :set_user_exercise, only: [:show, :edit, :update, :destroy]

  before_filter :require_permission, only: :edit 

  # GET /user_exercises
  # GET /user_exercises.json
  def index
    @date = Time.new 
    @user_exercise = UserExercise.new
    @user_exercise.day = @formatted_date
    @exercises = Exercise.all

    @month = @date.month 
    @year = @date.year 
    @selected_exercise = cookies[:exercise] 
    unless @selected_exercise.nil? 
      @month_total = UserExercise.find_total_by_user_exercise_month_and_year(session["user_id"], @selected_exercise, @month, @year) 
      @year_total = UserExercise.find_total_by_user_exercise_and_year(session["user_id"], @selected_exercise, @year)
    end
  end

  # GET /user_exercises/1
  # GET /user_exercises/1.json
  def show
  end

  # GET /user_exercises/new
  def new
    puts "Invoking new action" 
    @user_exercise = UserExercise.new
  end

  # GET /user_exercises/1/edit
  def edit
    @user_exercise = UserExercise.find_by_id(params[:id]) 
    @exercises = Exercise.all
  end

  # POST /user_exercises
  # POST /user_exercises.json
  def create
    @current_user = User.find(session["user_id"])
    @date = Date.strptime(user_exercise_params[:day], "%m/%d/%Y")
    @mysql_formatted_date = @date.strftime('%Y-%m-%d')
    @user_exercise = UserExercise.find_by_user_id_and_exercise_id_and_day(@current_user.id, user_exercise_params[:exercise_id], @mysql_formatted_date)
    if (@user_exercise.nil?) then 
      @user_exercise = UserExercise.new(user_exercise_params)
      @user_exercise.day = @date
      @user_exercise.user_id = @current_user.id 
    else
      @user_exercise.total = user_exercise_params[:total]
    end
    puts "rendering response" 
    puts @user_exercise.day 
    puts "****"
    respond_to do |format|
      if @user_exercise.save
	puts "save successful" 
        format.html { redirect_to :action => 'index', :id => @user_exercise, notice: 'Information saved successfully.' }
        format.json { render :index, status: :created, location: @user_exercise }
      else
        puts "Invalid object" 
        @exercises = Exercise.all
        format.html { render :index }
        format.json { render json: @user_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_exercises/1
  # PATCH/PUT /user_exercises/1.json
  def update
    respond_to do |format|
      @current_user = User.find(session["user_id"])
      @user_exercise.user_id = @current_user.id 
      if @user_exercise.update(user_exercise_params)
        format.html { redirect_to @user_exercise, notice: 'User exercise was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_exercise }
      else
        format.html { render :edit }
        format.json { render json: @user_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_exercises/1
  # DELETE /user_exercises/1.json
  def destroy
    @user_exercise.destroy
    respond_to do |format|
      format.html { redirect_to user_exercises_url, notice: 'User exercise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def find_by_user_exercise_and_day
    respond_to do |format| 
      @current_user = User.find(session["user_id"])
      format.js {
        @date = Date.strptime(params[:day], "%m/%d/%Y")
        @mysql_formatted_date = @date.strftime('%Y-%m-%d')
        @user_exercise = UserExercise.find_by_user_id_and_exercise_id_and_day(@current_user, params[:exercise], @mysql_formatted_date) 
        render :text => @user_exercise.nil? ? "" : @user_exercise.total 
      }
    end
  end

  def find_totals 
    respond_to do |format| 
      @current_user = User.find(session["user_id"])
      format.json {
        @month_total = UserExercise.find_total_by_user_exercise_month_and_year(session["user_id"], params[:exercise], params[:month], params[:year]) 
        @year_total = UserExercise.find_total_by_user_exercise_and_year(session["user_id"], params[:exercise], params[:year]) 
	render :json => {:month => @month_total, 
                                  :year => @year_total }
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_exercise
      @user_exercise = UserExercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_exercise_params
      params.require(:user_exercise).permit(:exercise_id, :day, :total)
    end

    def require_permission
      if current_user.id != UserExercise.find(params[:id]).user_id 
        redirect_to root_path
        #Or do something else here
      end
    end

end
