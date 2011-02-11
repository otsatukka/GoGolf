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

/*  jQuery(".sign_in_button").click(function() {
    jQuery("#sign_in").slideToggle("slow");
    	  $(this).toggleClass("active");
  });
});*/

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
  
/*  jQuery(function(){
    var path = location.pathname.substring(1);
    if ( path )
      jQuery('.nav li a[href$="' + path + '"]').attr('class', 'selected');
  });
  jQuery(function(){
    var path = location.pathname.substring(1);
    if ( path )
      jQuery('.nav a[href$="' + path + '"]').attr('class', 'highlighted');
  });*/
  jQuery('.nav li:not(:has(a))').addClass('selected');
});

/* FRONT PAGE SLIDER */
$(document).ready(function(){$('#button_slider a').click(function(){var integer=$(this).attr('rel');$('#myslide .cover').animate({left:-425*(parseInt(integer)-1)})
$('#button_slider a').each(function(){$(this).removeClass('active_s');if($(this).hasClass('button'+integer)){$(this).addClass('active_s')}});});});