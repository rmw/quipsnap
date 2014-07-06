var Users = {

  // Bind events to Bookclubs
  bind: function() {
    $('li').on('click', this.showQuotesForThisBookclub.bind(this));
  },

  init: function(model) {
    this.bind();
    // this.renderList();
  },

  showQuotesForThisBookclub: function(e) {
    e.preventDefault();
    var bookclubId = e.target.id;

    $(".quotes").children().remove;


    var ajaxRequest = $.ajax({
      url: '/bookclubs/' + bookclubId,
      type: 'GET'
    });
    // when new bookclub is valid, show it on the page
    ajaxRequest.done(this.showBookclubQuotes.bind(this));
    // when new bookclub is invalid, show error message in console log for now
    ajaxRequest.fail(function(data){
      console.log(data.responseJSON.message);
    });

  },


  showBookclubQuotes: function(response) {

    var quoteHTML = "";


    var quotes = response.quotes;
    var title = response.title;
    var authors = response.authors;
    var users = response.users;

    for (var i=0; i<quotes.length; i++) {
      quoteHTML += "<div class='quote' id='" + quotes[i].id + "'>";
      quoteHTML += "Content: " + quotes[i].content;
      if (title[i]!=null){
        quoteHTML += "<div>Title: " + title[i] + "</div>";
      }
      if (authors[i]!=null){
        quoteHTML += "<div>Author: " + authors[i].name + "</div>";
      }
      quoteHTML += "<div>Created by: " + users[i] + "</div>";
      quoteHTML += "<a href='/quotes/" + quotes[i].id + "'>Show More</a>";
    }
    $('.quotes').html(quoteHTML);
  }
};

  

//On document load
$(document).ready(function(){
  Users.init();



  
});