angular.module('todoAngular')
.controller('MainCtrl', [
  '$scope', 
  'TaskList',
  'Task',
  '$uibModal', 
  '$log',
  function($scope, TaskList, Task, $uibModal, $log){

  $scope.task_lists = TaskList.query();

  $scope.deleteTaskList = function(task_list){
    task_list.$delete(function() {
      $scope.task_lists.splice($scope.task_lists.indexOf(task_list), 1);
    });
  }; 

  $scope.editTaskList = function(task_list){
    TaskList.update({id: task_list.id}, {title: task_list.title});
  }

  $scope.showForm = function () {
    var modalInstance = $uibModal.open({
      templateUrl: '_new_task_list.html',
      controller: 'ModalCtrl',
      scope: $scope,
      resolve: {
        listForm: function () {
            return $scope.listForm;
          }
        }
      });

    modalInstance.result.then(function(selectedItem) {
      $scope.task_lists.push(selectedItem);
    }, function () {
      $log.info('Modal dismissed at: ' + new Date());
    });
  };

  $scope.addTask = function(task_list){

    if(task_list.description === '') { return; }

    task = new Task({
      description: task_list.description,
      task_list_id: task_list.id
    });
    task.$save(function(task){
      task_list.tasks.push(task);
    });

    task_list.description = '';
  };  

  $scope.deleteTask = function(task, task_list) {
    Task.delete({id: task.id}, function() {
      task_list.tasks.splice(task_list.tasks.indexOf(task), 1);
    });
  };

  $scope.editTask = function(task){
    Task.update({id: task.id}, {description: task.description});
  };

  $scope.toggleTask = function(task){
    Task.update({id: task.id}, {completed: task.completed});
  };

  $scope.setDeadline = function(task, newDate){
    Task.update({id: task.id}, {deadline: newDate});
  };

  $scope.sortListeners = {
    containerPositioning: 'relative',
      accept: function(sourceItemHandleScope, destSortableScope) {
        return sourceItemHandleScope.itemScope.sortableScope.$id === destSortableScope.$id;
    },
    orderChanged: function(event) {
      var id, position;
      task = event.source.itemScope.task;
      position = event.dest.index;
      Task.update({id: task.id}, {position: position});
    }
  };

}]);