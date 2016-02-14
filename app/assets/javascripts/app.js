angular.module('todoAngular', [
  'validation.match',
  'ngResource', 
  'ngMessages', 
  'ui.router', 
  'permission', 
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
        url: '/',
        templateUrl: '_home.html',
        controller: 'MainCtrl'
      })
      .state('tasks', {
        url: '/tasks/:id',
        templateUrl: '_task.html',
        controller: 'CommentCtrl'
      });

      $urlRouterProvider.otherwise('/');

}]);







