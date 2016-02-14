angular.module('todoAngular')
  .controller('UserRegistrationsCtrl', ['$scope', '$auth', function ($scope, $auth) {
    $scope.handleRegBtnClick = function() {
      $auth.submitRegistration($scope.registration)
        .then(function() { 
            $auth.submitLogin({
              email: $scope.registration.email,
              password: $scope.registration.password
            });
          });
    };

    $scope.$on('auth:registration-email-error', function(ev, reason) {
      $scope.error = reason.errors.full_messages[0];
    });

  }]);