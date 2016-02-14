angular.module('todoAngular')
.factory('Comment', ['$http','Upload',function($http, Upload){
  return {
    delete: function(id) {
      return $http.delete('/comments/' + id);
    },
    create_with_attachment: function (task_id, comment) {
     return Upload.upload({
          url: '/comments.json',
          method: 'POST',
          fields: { 
            'comment[body]': comment.body,
            'comment[task_id]': task_id
           },
          file: comment.file_attachment,
          fileFormDataName: 'comment[file_attachment]'
      });
    }
  };

}]);
