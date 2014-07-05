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


var Comment = {
	formHTML: function(quoteId){
		return "<form class='comment-form' action='/quotes/" + quoteId + "/comments/create' method='post'> " +
		  "<div style='display:none'>" +
		    "<input name='authenticity_token' type='hidden' value='NrOp5bsjoLRuK8IW5+dQEYjKGUJDe7TQoZVvq95Wteg=' />" +
		  "</div>" +
		  "<input class='comment-box' name='comment' type='textarea' placeholder='Your comment here' /><br />" +
		  "<input name='commit' type='submit' value='Submit Comment' />" +
		"</form>";
	},

	// display the add comment form to the user
	displayForm: function(selector, quoteId) {
		console.log(quoteId);
		var html = this.formHTML(quoteId);
		$(selector).append(html);
	}, 

	// send an ajax request to save the user's comment
	ajaxRequestToAdd: function(comment, action) {
		var ajaxRequest = $.ajax({
			url: action,
			type: "post",
			data: {comment: comment}
		});

		ajaxRequest.always(this.appendResponse);
	},

	// let the user briefly know if comment was saved successfully
	// this needs to be changed later. right now, the success status is prepended to the top of the page
	appendResponse: function(response) {
		$("form.comment-form").remove();
		
		$("body").prepend("<div class='add-comment-response'>" + response.responseText + "</div>");

		setTimeout(function() {
		  $("div.add-comment-response").remove();
		}, 1000);
	}

}

$(document).ready(function(){
	// when user adds a comment
	$(".add-comment").on("click", function(e){
		e.preventDefault();
		Comment.displayForm($(e.target).parent(), $(e.target).attr("data-quote-id"));
	});

	// when user submits a comment
	$(".quotes").on("submit", "form.comment-form", function(e){
		e.preventDefault();
		var comment = $(e.target).children("input.comment-box").val();
		var action = $(e.target).attr("action");
		Comment.ajaxRequestToAdd(comment, action);
	});	
})