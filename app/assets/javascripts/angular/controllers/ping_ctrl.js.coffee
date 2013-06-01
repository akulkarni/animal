App.controller 'DateCtrl', ['$scope', ($scope) ->

  dotw_names = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
  $scope.times = ['7am', '8am', '9am', '10am', '11am', '12pm', '1pm', '2pm', '3pm']

  now = new Date
  $scope.selectedTimes = []

  format_date = (dt) ->
    return dotw_names[dt.getDay()] + ' ' + (dt.getMonth() + 1) + '/' + dt.getDate()

  $scope.today = format_date(now)

  $scope.toggleTime = (time) ->
    i = $scope.selectedTimes.indexOf(time)
    if i == -1
      $scope.selectedTimes.push(time)
    else
      $scope.selectedTimes.splice(i, 1)
 
  $scope.getSelectedState = (time) ->
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

]