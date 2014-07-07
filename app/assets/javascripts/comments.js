var Comment = {
	commentChain: [],

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
				"<button class='reply-comment'>Reply</button>" +
			"</div>"
	},

	hiddenCommentHTML: function(commentId, content, user) {
		return	"<div style='display:none' data-comment-id='" + commentId + "' class='quote-comment'>" +
				"<div>" + content + "</div>" +
				"<div>Posted by: " + user + "</div>" + 
				"<button class='reply-comment'>Reply</button>" +
				"<button class='more-comments'></button>" + 
			"</div>"
	},

	lastHiddenCommentHTML: function(commentId, content, user) {
		return	"<div style='display:none' data-comment-id='" + commentId + "' class='quote-comment'>" +
				"<div>" + content + "</div>" +
				"<div>Posted by: " + user + "</div>" + 
				"<button class='reply-comment'>Reply</button>" +
			"</div>"
	},

	replyFormHTML: function(commentId){
		return "<form class='reply-comment-form' action='/quotes/comments/" + commentId + "/create' method='post'> " +
		  "<input class='reply-comment-box' name='reply' type='textarea' placeholder='Your reply here' /><br />" +
		  "<input name='commit' type='submit' value='Submit Reply' />" +
		"</form>";
	},

	// display the add comment form to the user
	displayForm: function(selector, quoteId) {
		var html = this.formHTML(quoteId);
		$(selector).append(html);
	}, 

	// display the add reply form to the user
	displayReplyForm: function(selector, commentId) {
		var html = this.replyFormHTML(commentId);
		$(selector).append(html);
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

	appendResponse: function(response) {
		if (response.isSuccess) {
			// if direct comment to a quote..., else is a reply to a comment
			if (!(response.quote_id == null) && response.parent_id == null) {
				$("div.quote-comments").append(this.commentHTML(response.comment_id, response.comment_content, response.user));
			} else {
				// if the parent div does not have a hide/see replies button, add it
				var parentDiv = $("div[data-comment-id="+response.parent_id+"]") 
				if (parentDiv.children("button.less-comments").length == 0 && parentDiv.children("button.more-comments").length == 0) {
					parentDiv.append("<button class='less-comments'></button>");
				}
				parentDiv.append(this.commentHTML(response.comment_id, response.comment_content, response.user));
			}
			this.displayMessage("Comment/Reply Saved Successfully");
		} else {
			this.displayMessage("Unable to Save Comment/Reply");
		}

	},

	// send an ajax request to save the user's comment
	ajaxRequestToAdd: function(comment, action) {
		var ajaxRequest = $.ajax({
			url: action,
			type: "post",
			data: {comment: comment, authenticity_token: AUTH_TOKEN}
		});

		ajaxRequest.always(this.appendResponse.bind(this));

	},

	appendCommentChain: function(){
		for (var i = 0; i < this.commentChain.length; i++) {
			for (var j = 0; j < this.commentChain[i].replies.length; j++) {
				this.recursiveCall(this.commentChain[i].replies[j]);
			}
		}
	},

	recursiveCall: function(comment) {
		if (comment.replies.length == 0) {
			$("div[data-comment-id="+comment.parent_id+"]").append(this.lastHiddenCommentHTML(comment.comment_id, comment.comment_content, comment.user));
		} else {
			$("div[data-comment-id="+comment.parent_id+"]").append(this.hiddenCommentHTML(comment.comment_id, comment.comment_content, comment.user));
			for (var i = 0; i < comment.replies.length; i++) {
				this.recursiveCall(comment.replies[i]);
			}	
		}
	}

}

$(document).ready(function(){
	// when user adds a comment
	$("button.add-comment").on("click", function(e){
		e.preventDefault();
		$("form.comment-form").remove();
		Comment.displayForm($(e.target).parent().parent(), $(e.target).attr("data-quote-id"));
	});

	// when user submits a comment
	$("div.quote").on("submit", "form.comment-form", function(e){
		e.preventDefault();
		var comment = $(e.target).children("input.comment-box").val();
		var action = $(e.target).attr("action");
		Comment.ajaxRequestToAdd(comment, action);
	});	

	// from quote show page, user can reply to a comment
	$("div.quote-comments").on("click", "button.reply-comment", function(e){
		e.preventDefault();
		$("form.reply-comment-form").remove();
		var parentCommentId = $(e.target).parent().attr("data-comment-id");
		Comment.displayReplyForm($(e.target).parent(), parentCommentId)
	});

	// from quote show page, user submits a reply to a comment
	$("div.quote-comments").on("submit", "form.reply-comment-form", function(e){
		e.preventDefault();
		var reply = $(e.target).children("input.reply-comment-box").val();
		var action = $(e.target).attr("action");
		Comment.ajaxRequestToAdd(reply, action);
	});

	// from quote show page, user can expand replies for a comment
	$("div.quote-comments").on("click", "button.more-comments", function(e){
		e.preventDefault();
		$(e.target).parent().children('div.quote-comment').show();
		// $(e.target).text("Hide replies");
		$(e.target).removeClass("more-comments");
		$(e.target).addClass("less-comments");
	});

	// from quote show page, user can collapse replies for a comment
	$("div.quote-comments").on("click", "button.less-comments", function(e){
		e.preventDefault();
		$(e.target).parent().children('div.quote-comment').hide();
		// $(e.target).text("See replies");
		$(e.target).removeClass("less-comments");
		$(e.target).addClass("more-comments");
	});

	// if user is on the quote show page, send an ajax request to get all comment replies
	if ($("div.quote-comments").length > 0) {
		var commentIds = [];
		var comments = $("div.quote-comments").children();

		for (var i = 0 ; i < comments.length; i++) {
			commentIds.push(comments[i].getAttribute("data-comment-id"))
		}

		var ajaxRequest =  $.ajax({
			url: "/comments/replies",
			type: "GET",
			data: { comment_ids: commentIds }
		});

		ajaxRequest.always(function(response){
			Comment.commentChain = response;
			Comment.appendCommentChain();
		});
	}

})