//  core functionality for navigation drop down
var app = angular.module('PlacematApp', [], function($interpolateProvider) {
  $interpolateProvider.startSymbol('[[');
  $interpolateProvider.endSymbol(']]');
});
