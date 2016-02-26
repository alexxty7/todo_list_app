angular.module('todoAngular')
.factory('TaskList', ['$resource', function($resource) {
  return $resource('/task_lists/:id', { id: '@id' }, {
    update: { method: 'PUT' }
  }); 
}]);