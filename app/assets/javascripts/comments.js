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
	$("button.add-comment").on("click", function(e){
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

	// from quote show page, user can see reply to a comment
	$("button.more-comments").on("click", function(e){
		var parentCommentId = $(e.target).parent().attr("data-comment-id");
		console.log(parentCommentId);
	});
	// from quote show page, user can reply to a comment
	$("button.reply-comment").on("click", function(e){
		var parentCommentId = $(e.target).parent().attr("data-comment-id");
		console.log(parentCommentId);
	});
})