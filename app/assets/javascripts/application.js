// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var commentFormHTML = "<form class='comment-form' action='/comments/create' method='post'> " +
						  "<div style='display:none'>" +
						    "<input name='authenticity_token' type='hidden' value='NrOp5bsjoLRuK8IW5+dQEYjKGUJDe7TQoZVvq95Wteg=' />" +
						  "</div>" +
						  "<input class='comment-box' name='comment' type='textarea' placeholder='Your comment here' /><br />" +
						  "<input name='commit' type='submit' value='Submit Comment' />" +
						"</form>"

var displayCommentForm = function(selector) {
	$(selector).append(commentFormHTML);
};

var ajaxRequestAddComment = function(comment) {
	var ajaxRequest = $.ajax({
		url: "/comments/create",
		type: "post",
		data: {comment: comment}
	});

	ajaxRequest.always(appendComment);
};

var appendComment = function(response) {
	console.log(response.responseText);
	console.log(response);
	$("form.comment-form").remove();
	$("body").prepend("<div class='add-comment-response'>" + response.responseText + "</div>");
	setTimeout(function() {
	  $("div.add-comment-response").remove();
	}, 1000);
};

$(document).ready(function(){
	// adding a comment
	$(".add-comment").on("click", function(e){
		e.preventDefault();
		console.log("add comment!");
		displayCommentForm($(e.target).parent());
	});

	//submitting a comment
	$(".quotes").on("submit", "form.comment-form", function(e){
		e.preventDefault();
		console.log("submit comment!");
		var comment = $(e.target).children("input.comment-box").val();
		ajaxRequestAddComment(comment);
	});	
})