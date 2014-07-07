var quoteFavorites = {
	likeQuote: function (selector) {
		$(selector).removeClass("unliked-quote");
		$(selector).addClass("liked-quote");
	},

	unlikeQuote: function(selector) {
		$(selector).removeClass("liked-quote");
		$(selector).addClass("unliked-quote");
	},

	addToFavorites: function(selector) {
		var quoteId = $(selector).parent().parent().attr("id");
		var ajaxRequest = $.ajax({
			url: "/quotes/" + quoteId + "/favorite",
			type: "post"
		});
	},

	removeFromFavorites: function(selector) {
		var quoteId = $(selector).parent().parent().attr("id");
		var ajaxRequest = $.ajax({
			url: "/quotes/" + quoteId + "/unfavorite",
			type: "delete"
		});
	}
};

$(document).ready(function(){
	// user favorites a quote
	$(".quote-options").on("click", "button.unliked-quote", function(e) {
		e.preventDefault();
		quoteFavorites.likeQuote(e.target);
		quoteFavorites.addToFavorites(e.target);
	});

	// user unfavorites a quote
	$(".quote-options").on("click", "button.liked-quote", function(e) {
		e.preventDefault();
		quoteFavorites.unlikeQuote(e.target);
		quoteFavorites.removeFromFavorites(e.target);
	});
});