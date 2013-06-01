App.controller 'DateCtrl', ['$scope', ($scope) ->

  dotw_names = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")

  $scope.hours = ['7am', '8am', '9am', '10am', '11am', '12pm', '1pm', '2pm', '3pm', '4pm', '5pm', '6pm', '7pm']

  now = new Date
  now = new Date(now.getFullYear(), now.getMonth(), now.getDate())
  $scope.selectedTimes = []

  format_date = (dt) ->
    return dotw_names[dt.getDay()] + ' ' + (dt.getMonth() + 1) + '/' + dt.getDate()

  $scope.today = format_date(now)

  convert_hour_to_time = (hour) ->
    numeric_hour = parseInt(hour.substring(0, hour.length - 2))
    time_of_day = hour.substring(hour.length - 2, hour.length)
    if time_of_day == 'pm' and numeric_hour < 12
      numeric_hour = numeric_hour + 12

    time = now
    time.setHours(numeric_hour)
    return time.toJSON()

  $scope.toggleTime = (hour) ->
    time = convert_hour_to_time(hour)
    i = $scope.selectedTimes.indexOf(time)
    if i == -1
      $scope.selectedTimes.push(time)
    else
      $scope.selectedTimes.splice(i, 1)
 
  $scope.getSelectedState = (hour) ->
    time = convert_hour_to_time(hour)
    if time in $scope.selectedTimes
      return true
    else
      return false

  $scope.nextDate = () ->
    now.setDate(now.getDate() + 1)
    $scope.today = format_date(now)

  $scope.prevDate = () ->
    now.setDate(now.getDate() - 1)
    $scope.today = format_date(now)

  $scope.cancel_test = () ->
    $scope.hours.push('BAM')

]