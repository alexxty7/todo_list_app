angular.module('todoAngular')
.controller('ModalCtrl', [
  '$scope',
  '$uibModalInstance',
  'userForm',
  'TaskList',
  function($scope, $uibModalInstance, userForm, TaskList){

    $scope.form = {}
    
    $scope.submitForm = function () {
      
        if ($scope.form.userForm.$valid) {
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