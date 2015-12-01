angular.module('sensors').controller('cGeolocationController', function($scope, supersonic, $timeout) {
  steroids.view.setBackgroundColor("#FFFFFF");
  $scope.position = {
    latitude: 0,
    longitude: 0,
    accuracy: 100
  };
  $scope.isGettingPosition = false;
  $scope.isWatchingPosition = false;
  $scope.getPosition = function() {
    if ($scope.isGettingPosition || $scope.isWatchingPosition) {
      return;
    }
    $scope.isGettingPosition = true;
    return supersonic.device.geolocation.getPosition().then(function(position) {
      return $scope.position = position.coords;
    })["finally"](function() {
      return $scope.isGettingPosition = false;
    });
  };
  $scope.startWatchingPosition = function() {
    if ($scope.isWatchingPosition) {
      return;
    }
    $scope.isWatchingPosition = true;
    return supersonic.device.geolocation.watchPosition({
      enableHighAccuracy: true
    }).onValue(function(position) {
      return $timeout(function() {
        return $scope.position = position.coords;
      });
    });
  };
  $scope.stopWatchingPosition = function() {
    return $scope.isWatchingPosition = false;
  };
  $scope.toggleWatch = function() {
    if ($scope.isWatchingPosition) {
      return $scope.stopWatchingPosition();
    } else {
      return $scope.startWatchingPosition();
    }
  };
  supersonic.ui.views.current.whenVisible(function() {
    if (!$scope.isWatchingPosition) {
      return $scope.getPosition();
    }
  });
  if (!$scope.isWatchingPosition) {
    return $scope.getPosition();
  }
});