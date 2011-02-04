$(document).ready(function() {
	$("form#new_user #user_login").mirrorFieldTo("form#new_user #user_twitter_name");
    });


/**
 * Mirror one field to another, as long as the target field has not been modified
 * Usage: $("#my_field").mirrorFieldTo("#another_field");
 */
jQuery.fn.mirrorFieldTo = function(target_selector) {
    var target = jQuery(target_selector);

    // Keep track of whether the target field has been modified
    target.data('modified', false);
    target.change(function() { jQuery(this).data('modified', true); });


    // If the target hasn't been modified, mirror the source field to it
    var mirror_fn = function() {
	if(!target.data('modified')) {
	    target.val(jQuery(this).val());
	}
    };
    jQuery(this).keyup(mirror_fn).blur(mirror_fn);
}
