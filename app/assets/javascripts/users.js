var Users = {

  // Bind events to Bookclubs
  bind: function() {
    $('li').on('click', this.showQuotesForThisBookclub.bind(this));
  },

  init: function(model) {
    this.bind();
    // this.renderList();
  },

  instructionsHover: function() {
    $('input.nav-signout').qtip({
        content: 'Signout',
        style: {
                 classes: 'qtip-blue qtip-shadow qtip-rounded qtip-cluetip',
                 'font-size': '12px'

              },
        position: {
                    my: 'top center',  // Position my top left...
                    at: 'bottom center', // at the bottom right of...
                    target: $('input.nav-signout') // my target
              }
        });
    $('input.nav-bookclubs').qtip({
        content: 'Bookclubs',
        style: {
                color: 'black'
              },
              position: {
                    my: 'top center',  // Position my top left...
                    at: 'bottom center', // at the bottom right of...
                    target: $('input.nav-bookclubs') // my target
              }
        });
    $('input.nav-favorites').qtip({
        content: 'My Favorites',
        style: {
                color: 'black'
              },
              position: {
                    my: 'top center',  // Position my top left...
                    at: 'bottom center', // at the bottom right of...
                    target: $('input.nav-favorites') // my target
              }
        });
    $('input.nav-notebook').qtip({
        content: 'My Notebook',
        style: {
                color: 'black'
              },
              position: {
                    my: 'top center',  // Position my top left...
                    at: 'bottom center', // at the bottom right of...
                    target: $('input.nav-notebook') // my target
              }
        });
    $('input.nav-public').qtip({
        content: 'All Quotes',
        style: {
                color: 'black'
              },
              position: {
                    my: 'top center',  // Position my top left...
                    at: 'bottom center', // at the bottom right of...
                    target: $('input.nav-public') // my target
              }
        });
        
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
      quoteHTML += "<div class='content'>" + quotes[i].content + "</div>";
      if (authors[i]!=null){
        quoteHTML += "<a class='search-author'>" + authors[i].name + "</a>";
      }
      if (title[i]!=null){
        quoteHTML += "<a class='search-title'>" + title[i] + "</a>";
      }
      quoteHTML += "<div class='search-user'>Created by: " + users[i] + "</div>";
      quoteHTML += "<div class='quote-options'>"
      quoteHTML += "<button class='show-quote' href='/quotes/" + quotes[i].id + "'>Show More</button>";
      quoteHTML += "</div></div>";
    }
    $('.quotes').html(quoteHTML);
  }
};

  

//On document load
$(document).ready(function(){
  Users.init();

  Users.instructionsHover();
    




  
});