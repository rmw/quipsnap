var Comment = {
	formHTML: function(quoteId){
		return "<form class='comment-form' action='/quotes/" + quoteId + "/comments/create' method='post'> " +
		  "<input class='comment-box' name='comment' type='textarea' placeholder='Your comment here' /><br />" +
		  "<input name='commit' type='submit' value='Submit Comment' />" +
		"</form>";
	},

	commentHTML: function(commentId, content, user) {
		return	"<div data-comment-id='" + commentId + "' class='quote-comment'>" +
				"<div>" + content + "</div>" +
				"<div>Posted by: " + user + "</div>" + 
				"<button class='more-comments'>See replies</button>" + 
				"<button class='reply-comment'>Reply</button>" +
			"</div>"
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
			data: {comment: comment, authenticity_token: AUTH_TOKEN}
		});
		// if ajax request was a quote's direct comment
		ajaxRequest.always(this.appendResponse.bind(this));

		// if ajax request was a reply to a comment, do something else ...
	},

	appendResponse: function(response) {
		console.log(response);
		if (response.isSuccess) {
			// if direct comment to a quote..., else is a reply to a comment
			if (!response.quote_id == null && response.parent_id == null) {
				$("div.quote-comments").append(this.commentHTML(response.comment_id, response.comment_content, response.user));
			} else {
				$("div[data-comment-id="+response.parent_id+"]").append(this.commentHTML(response.comment_id, response.comment_content, response.user));
			}
			this.displayMessage("Comment/Reply Saved Successfully");
		} else {
			this.displayMessage("Unable to Save Comment/Reply");
		}

	},

	// let the user briefly know if comment was saved successfully
	// this needs to be changed later. right now, the success status is prepended to the top of the page
	displayMessage: function(message) {
		$("form.comment-form").remove();
		$("form.reply-comment-form").remove();
		
		$("body").prepend("<div class='add-comment-response'>" + message + "</div>");

		setTimeout(function() {
		  $("div.add-comment-response").remove();
		}, 1000);
	},

	replyFormHTML: function(commentId){
		return "<form class='reply-comment-form' action='/quotes/comments/" + commentId + "/create' method='post'> " +
		  "<input class='reply-comment-box' name='reply' type='textarea' placeholder='Your reply here' /><br />" +
		  "<input name='commit' type='submit' value='Submit Reply' />" +
		"</form>";
	},

	// display the add comment form to the user
	displayReplyForm: function(selector, commentId) {
		var html = this.replyFormHTML(commentId);
		$(selector).append(html);
	}

}

$(document).ready(function(){
	// when user adds a comment
	$("button.add-comment").on("click", function(e){
		e.preventDefault();
		console.log("add comment button clicked");
		Comment.displayForm($(e.target).parent(), $(e.target).attr("data-quote-id"));
	});

	// when user submits a comment
	$("div.quote").on("submit", "form.comment-form", function(e){
		e.preventDefault();
		console.log("submit comment button clicked");
		var comment = $(e.target).children("input.comment-box").val();
		var action = $(e.target).attr("action");
		Comment.ajaxRequestToAdd(comment, action);
	});	

	// from quote show page, user can reply to a comment
	$("div.quote-comments").on("click", "button.reply-comment", function(e){
		e.preventDefault();
		console.log("reply comment button clicked");
		var parentCommentId = $(e.target).parent().attr("data-comment-id");
		Comment.displayReplyForm($(e.target).parent(), parentCommentId)
	});

	// from quote show page, user submits a reply to a comment
	$("div.quote-comments").on("submit", "form.reply-comment-form", function(e){
		e.preventDefault();
		console.log("submit reply button clicked");
		var reply = $(e.target).children("input.reply-comment-box").val();
		var action = $(e.target).attr("action");
		Comment.ajaxRequestToAdd(reply, action);
	});
/*
	// from quote show page, user can see reply to a comment
	$("div.quote-comments").on("click", "button.more-comments", function(e){
		e.preventDefault();
		console.log("see comment replies button clicked");
		var parentCommentId = $(e.target).parent().attr("data-comment-id");
		console.log(parentCommentId);
	});*/
})