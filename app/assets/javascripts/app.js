angular.module('todoAngular', [
  'validation.match',
  'ngResource', 
  'ngMessages',
  'ui.router', 
  'templates',              
  'ui.bootstrap', 
  'ui.bootstrap.datetimepicker', 
  'mk.editablespan', 
  'as.sortable', 
  'ngFileUpload', 
  'ng-token-auth'
])
.config(['$authProvider', function($authProvider){
    $authProvider.configure({
      apiUrl: '',
      omniauthWindowType: 'newWindow'   
    })
}])
.run([
    '$rootScope', 
    '$state',
    function($rootScope, $state) {
    
  $rootScope.$on('auth:login-success', function() {
    $state.go('task_lists');
  });
  
  $rootScope.$on('auth:logout-success', function() {
    $state.go('sign_in');
  });

}]);






