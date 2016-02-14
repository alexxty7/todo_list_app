angular.module('todoAngular').factory('Task', function($resource) {
  return $resource('/tasks/:id', { id: '@id' }, {
    update: { method: 'PATCH' },
    sort: { params: { action: 'sort' }, method: 'PATCH' }
  }); 
});