angular.module('todoAngular')
.controller('CommentCtrl', [
  '$scope',
  'Task',
  '$stateParams',
  'Comment',
  function($scope, Task, $stateParams, Comment){

    $scope.task = Task.get({id: $stateParams.id});

    $scope.addComment = function(){
        Comment.create_with_attachment($scope.task.id, $scope.comment)
        .then(function (resp) {
            $scope.task.comments.push(resp.data);
        });

        $scope.comment.body = '';
        $scope.comment.file_attachment = '';
    };

    $scope.deleteComment = function(comment){
      Comment.delete(comment.id);
      $scope.task.comments.splice($scope.task.comments.indexOf(comment), 1);
    };
}]);