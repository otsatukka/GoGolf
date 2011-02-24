/*
Jquery and Rails powered default application.js
Easy Ajax replacement for remote_functions and ajax_form based on class name
All actions will reply to the .js format
Unostrusive, will only works if Javascript enabled, if not, respond to an HTML as a normal link
respond_to do |format|
  format.html
  format.js {render :layout => false}
end
*/

/* POST-INDEX AJAX LINKIT*/
$(function() {
    $("#posts a").live("click", function() {
      $.getScript(this.href);
      return false;
    });
    $("#posts_search").submit(function() {
      $.get(this.action, $(this).serialize(), null, "script");
      return false;
    });
});
$(document).ready(function() {
  $.featureList(
    $("#tabs li a"),
    $("#output li"), $("#description1 li"), {
      start_item : 1
      }
    );
});

/* ADMIN OSIO 
$(document).ready(function() {
  jQuery('.submittable').live('change', function() {
    $(this).parents('form').submit();
    return false;
  });
});*/

jQuery.ajaxSetup({ 'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} })

/* KIRJAUTUMINEN */
$(document).ready(function() {
  jQuery(".sign_in_button").button({
    icons: {
      primary: "ui-icon-locked"
    }
  });
  
  jQuery(".button").button();
  jQuery(".button_s").button();
  jQuery("#sign_in").hide();
  jQuery("#sign_in2").hide();
  jQuery("#spede").click(function() {
    jQuery("#spede").hide();
  });
  

  
  jQuery(".sign_in_button").click(function() {
    jQuery("#sign_in2").dialog({
      title: "Kirjaudu sisään",
      height: 330,
      width: 700,
      modal: true
      });
    	  $(this).toggleClass("active");
  });
});

/* NAVI */
$(document).ready(function() {
  jQuery('.nav li:not(:has(a))').addClass('selected');
});