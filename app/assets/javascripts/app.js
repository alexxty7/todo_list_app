angular.module('todoAngular', [
  'validation.match',
  'ngResource', 
  'ngMessages', 
  'permission',
  'ui.router', 
  'templates',              
  'ui.bootstrap', 
  'ui.bootstrap.datetimepicker', 
  'mk.editablespan', 
  'as.sortable', 
  'ngFileUpload', 
  'ng-token-auth'
])
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
        controller: 'UserSessionsCtrl',
        data: {
          permissions: {
            only: ['anonymous'],
            redirectTo: 'task_lists'
          }
        }
      })

      .state('sign_up', {
        url: '/sign_up',
        templateUrl: 'user_registrations/_new.html',
        controller: 'UserRegistrationsCtrl',
        data: {
          permissions: {
            only: ['anonymous'],
            redirectTo: 'task_lists'
          }
        }
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

}])
.config(['$authProvider', function($authProvider){
    $authProvider.configure({
      apiUrl: '',
      omniauthWindowType: 'newWindow'   
    })
}]);

angular.module('todoAngular')
  .run([
    '$rootScope', 
    '$state',
    'PermissionStore',
    function($rootScope, $state, PermissionStore) {
    
  $rootScope.$on('auth:login-success', function() {
    $state.go('task_lists');
  });
  
  $rootScope.$on('auth:logout-success', function() {
    $state.go('sign_in');
  });

  PermissionStore.definePermission('anonymous', function (stateParams) {
    if (!$rootScope.user.signedIn) {
      return true; // Is anonymous
    }
    return false;
  });

}]);






