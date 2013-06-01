App.controller 'DateCtrl', ['$scope', ($scope) ->

  now = new Date
  dotw_names = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
  $scope.today = dotw_names[now.getDay()] + ' ' + (now.getMonth() + 1) + '/' + now.getDate()

  $scope.times = ['7am', '8am', '9am', '10am', '11am', '12pm', '1pm', '2pm', '3pm']

  $scope.selectedTimes = []
  $scope.toggleTime = (time) ->
    $scope.today = $scope.selectedTimes

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


]