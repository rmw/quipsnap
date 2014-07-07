var quoteFavorites = {

};

$(document).ready(function(){
	// user favorites a quote
	$(".quote-options").on("click", "button.unliked-quote", function(e) {
		e.preventDefault();
		$(e.target).removeClass("unliked-quote");
		$(e.target).addClass("liked-quote");
		// send an ajax request to update the database
	});

	// user unfavorites a quote
	$(".quote-options").on("click", "button.liked-quote", function(e) {
		e.preventDefault();
		$(e.target).removeClass("liked-quote");
		$(e.target).addClass("unliked-quote");
		// send an ajax request to update the database
	});
});