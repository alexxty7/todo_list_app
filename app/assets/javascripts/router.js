angular.module('todoAngular')
.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

    $stateProvider
      .state('task_lists', {
        url: '/task_lists',
        templateUrl: '_home.html',
        controller: 'MainCtrl',
        resolve: {
          auth: ['$auth', function($auth) {
            return $auth.validateUser();
          }]
        }
      })

      .state('sign_in', {
        url: '/sign_in',
        templateUrl: 'user_sessions/_new.html',
        controller: 'UserSessionsCtrl'
      })

      .state('sign_up', {
        url: '/sign_up',
        templateUrl: 'user_registrations/_new.html',
        controller: 'UserRegistrationsCtrl'
      })

      .state('tasks', {
        url: '/tasks/:id',
        templateUrl: '_task.html',
        controller: 'CommentCtrl',
        resolve: {
          auth: ['$auth', function($auth) {
            return $auth.validateUser();
          }]
        }
      });

      $urlRouterProvider.otherwise('/sign_in');

}]);
