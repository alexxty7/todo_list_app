angular.module('todoAngular')
.directive('hover', function() {
  return {
    restrict: 'A',
    link: function(scope, element, attrs){
      element.bind('mouseenter', function() {
        element.addClass('hovered');
      }).bind('mouseleave', function() {
        element.removeClass('hovered');
      });
    }
  };
})

