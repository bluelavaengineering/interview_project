// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {
    var REFRESH_INTERVAL_IN_MILLIS = 10000;
     if ($('.f-pending-message').length > 0) {
       setTimeout(function(){
        Turbolinks.enableTransitionCache(true);
        Turbolinks.visit(location.toString());
        Turbolinks.enableTransitionCache(false);
         }, REFRESH_INTERVAL_IN_MILLIS);
    }
});
