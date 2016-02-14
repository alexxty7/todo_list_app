angular.module('todoAngular').factory('TaskList', function($resource) {
  return $resource('/task_lists/:id', { id: '@id' }, {
    update: { method: 'PATCH' }
  }); 
});