# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', -> $('#datepicker').datepicker
    dateFormat: 'mm/dd/yy' 
    altField: '#user_exercise_day' 
    onSelect: (date) -> 
      updateTotal(); 

updateTotal = (arg) -> 
  exercise = $('#user_exercise_exercise_id').val()
  date = $("#datepicker").datepicker('getDate')
  day = $('#user_exercise_day').val()
  month = date.getMonth() + 1              
  year =  date.getFullYear()
  if (exercise != "" && day != "")
    # Populate the total for the day 
    $.ajax
      url: "/user_exercises/find_by_user_exercise_and_day"
      type: 'GET'
      data: {day: day, exercise: exercise}
      success: (data) ->
        $('#user_exercise_total').val(data)
      error: ->
        alert "Something went wrong getting day total"
    # Populate the month and year totals 
    $.ajax
      url: "/user_exercises/find_totals"
      type: 'GET'
      data: {month: month, year: year, exercise: exercise}
      success: (data) ->
        $('#month_total').text(data.month)
        $('#year_total').text(data.year)
      error: ->
        alert "Something went wrong getting month and year total"


$ ->
  $("#user_exercise_exercise_id").change (e) ->
    e.preventDefault()
    updateTotal()  
    $.cookie("exercise", $('#user_exercise_exercise_id').val()) 

