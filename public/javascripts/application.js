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


/* 
 AJAX PAGINATION
*/
$(function() {
  $('#posts .pagination a').live('click', function() {
    $.get(this.href, { paginate: 'posts' }, null, 'script');
    return false;
  });
  $('#links .pagination a').live('click', function() {
    $.get(this.href, { paginate: 'links' }, null, 'script');
    return false;
  });
  $('#openings .pagination a').live('click', function() {
    $.get(this.href, { paginate: 'links' }, null, 'script');
    return false;
  });
});


/* IMPORTANT */
$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});

/* POST-INDEX AJAX LINKIT*/
$(document).ready(function() {
    $("#posts td a").live("click", function() {
      $.getScript(a.href);
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
  
  
  $("#button_1").attr('checked', false);
  jQuery(".button").button();
  jQuery(".button_s").button();
  jQuery("#sign_in").hide();
  jQuery("#post_use_uploaded_image_0, #opening_use_uploaded_image_0").hide();
  jQuery("#post_use_uploaded_image_1, #opening_use_uploaded_image_1").hide();
  jQuery("#imagebank").hide();
  jQuery("#upload_photo").hide();
  jQuery("#sign_in2").hide();
  jQuery("#spede").click(function() {
    jQuery("#spede").hide();
  });
  
  $("#imagebank input:radio").change(function() {
    $("#remove_photo input:checkbox").attr('checked', true);
    
    return false;
  });
  $("#remove_photo input:checkbox").change(function() {
    $("#post_use_uploaded_image_1, #opening_use_uploaded_image_1").attr('checked', false);
    $("#post_use_uploaded_image_0, #opening_use_uploaded_image_0").attr('checked', true);
    
    return false;
  });
  
  $(".image_bank_button").click(function () {
    $("#post_use_uploaded_image_1, #opening_use_uploaded_image_1").attr('checked', false);
    $("#post_use_uploaded_image_0, #opening_use_uploaded_image_0").attr('checked', true);
    $("#imagebank input:radio").attr('checked', false);
    
    $("#imagebank").slideToggle('slow');
    $("#upload_photo").hide('slow');
    return false
  });
  $(".upload_photo_button").click(function () {
    $("#post_use_uploaded_image_1, #opening_use_uploaded_image_1").attr('checked', true);
    $("#post_use_uploaded_image_0, #opening_use_uploaded_image_0").attr('checked', false);
    $("#upload_photo input:file").attr({ value: '' });;
    
    $("#upload_photo").slideToggle('slow');
    $("#imagebank").hide('slow');
    return false
  });
  jQuery("#post_use_uploaded_image_1, #opening_use_uploaded_image_1").change(function() {
    jQuery("#upload_photo input:file").attr('disabled',false);
    jQuery("#imagebank input:radio").attr('disabled',true);
    return false;
  });
  jQuery("#post_use_uploaded_image_0, #opening_use_uploaded_image_0").change(function() {
    jQuery("#imagebank input:radio").attr('disabled',false);
    jQuery("#upload_photo input:file").attr('disabled',true);
    return false;
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