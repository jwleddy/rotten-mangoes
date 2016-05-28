// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function() {

  function assignToColumn(movieBox) {
    var shortestIdx = $('.movie-col')
    .toArray()
    .map((x) => $(x).height())
    .reduce((prev,cur,idx,arr) => cur < arr[prev] ? idx : prev, 0);
    movieBox.appendTo('.movie-col:eq(' + shortestIdx + ')');
  }

  function applyToGrid() {
    for (i = 0; i <= $('#holder .movie-box').length; i += 4) {
      $('#holder .movie-box').slice(0,4).sort(function(a, b) {
        return $(a).height() < $(b).height() ? 1 : -1;
      }).each(function() {
        $(this).removeClass('col-md-3');
        assignToColumn($(this));
      });
    }
  }

applyToGrid();

});
