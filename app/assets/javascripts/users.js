// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function() {

    // this initialized skrollr js funcationality
    var s = skrollr.init({
        smoothScrolling: false,
        forceHeight: false
      });

    // this will change the background color corresponding to the mood selected
      if ($("#happyaf").length){  
        $(document.body).css({"background-color" : "rgb(255, 213, 0)"});
      }

      if ($("#sadaf").length){  
        $(document.body).css({"background-color" : "rgb(51, 0, 255)"});
      }

      if ($("#moodyaf").length){  
        $(document.body).css({"background-color" : "rgb(255, 0, 60)"});
      }
ß

});

