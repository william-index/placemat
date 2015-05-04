---
---
// Front matter allows jekyll injection in javasceipt
app.controller('SideBar', ['$scope', function($scope) {

  // Select Items
  $scope.items = [
    {
        id: '{{ "/index.html" | prepend: site.baseurl }}',
        name: 'About'},
    {
        id: '{{ "/installation.html" | prepend: site.baseurl }}',
        name: 'Installation'},
    {
        id: '{{ "/usage.html" | prepend: site.baseurl }}',
        name: 'Usage'},
    {% for post in site.posts %}
      {
        id: '{{ post.url | prepend: site.baseurl }}',
        name: '{{ post.title }}'},
    {% endfor %}
  ];

  // uses the current filepath to select the default
  $scope.current_page = [
    {id: window.location.pathname}
  ];

  $scope.select = {type : $scope.current_page[0].id};

  /**
  * Changes window location for select value
  **/
  $scope.update = function(select_value) {
    window.location = select_value;
	};
}]);
