angular.module('todoAngular')
.controller('ModalCtrl', [
  '$scope',
  '$uibModalInstance',
  'listForm',
  'TaskList',
  function($scope, $uibModalInstance, listForm, TaskList){

    $scope.form = {}
    
    $scope.submitForm = function () {
      
        if ($scope.form.listForm.$valid) {
            task_list = new TaskList({title: $scope.name});
            task_list.$save(function(data){
               $uibModalInstance.close(data);
            });

        } else {
            console.log('userform is not in scope');
        }
    };

    $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
    };

  }]);