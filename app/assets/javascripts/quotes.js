

var Quote = {
	// make quote draggable and droppable to add to bookclub
	addToBookclub: function(quoteId,bookclubId) {
		var ajaxRequest = $.ajax({
			url: '/bookclubs/' + bookclubId + '/quotes/' + quoteId,
			type: "post"
		});
	},

	almostToBookclub: function(event,ui) {
		$(this).css("background-color", "blue");
	},

	offOfBookclub: function(event,ui) {
		$("li").css("background-color", "white");
		ui.draggable.mouseup(function(){
			var top = ui.draggable.data('orgTop');
			var left = ui.draggable.data('orgLeft');
			ui.position = { top: top, left: left };
			console.log(ui.position);
		});
	}

};





$(document).ready(function(){
	//quote is a draggable object that reverts back to original position
	
	$("div.quote").draggable({
		revert: function(dropped){
			var dropped = dropped && dropped[0].id == "droppable";
           return !dropped;
		},
		revertDuration: 150
	}).each(function() {
		var top = $(this).position().top;
		var left = $(this).position().left;
		var quoteId = $(this).attr("id")
		$(this).data('orgTop', top);
		$(this).data('orgLeft', left);

	});

	//quote can be dropped on bookclub li and will be added to bookclub quotes
	$("li").droppable({
		drop:function(event,ui) {
			var quoteId = $(ui.draggable).attr("id");
			var bookclubId = $(this).attr("id");
			Quote.addToBookclub(quoteId,bookclubId);
			$(this).css("background-color", "green");
			$(this).animate({backgroundColor: 'white'}, 700);
	},
		over:Quote.almostToBookclub,
		out:Quote.offOfBookclub
	
	});

})

