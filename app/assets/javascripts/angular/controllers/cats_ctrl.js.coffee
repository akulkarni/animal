App.controller 'CatsCtrl', ['$scope', ($scope) ->

  $scope.cats = ["Call", "Coffee", "Drink", "Breakfast", "Lunch", "Dinner"]

  $scope.selected_cat = ""
  $scope.click = (cat) ->
    $scope.selected_cat = cat

]