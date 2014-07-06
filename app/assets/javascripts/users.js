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

    // var newBook = $(e.target).serialize();

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
    console.log(response);
    var quoteHTML = "";
    // "<div class='quote' id='<%=quote.id%>'>
    //   <div>Content: <%= quote.content %></div>
    //   <% unless quote.book.nil? %><div>Title: <%= quote.book.title %></div><% end %>
    //   <% unless quote.book.nil? %><div>Author: <%= quote.author.name %></div><% end %>
    //   <div>Created by: <%= quote.user.goodreads_name %></div>
    //   <a href="/quotes/<%= quote.id %>">See more</a>
    //   <% if logged_in? %>
    //     <button data-quote-id='<%= quote.id %>' class="add-comment">Add Comment</button>
    //   <% end %>
    // </div>"

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
        quoteHTML += "<div>Author: " + authors[i] + "</div>";
      }
      quoteHTML += "<div>Created by: " + users[i] + "</div>";
      quoteHTML += "<a href='/quotes/" + quotes[i].id + "'>Show More</a>";
    }
    $('.quotes').hide();
    $('.bookclub_quotes').append(quoteHTML);
  }
};

  // Render list of bookclubs
//   renderList: function() {
//     // Fetch bookclubs on load
//     var ajaxRequest = $.ajax({
//       url: '/bookclubs/:bookclub_id',
//       type: 'GET'
//     });
//     ajaxRequest.done(this.showBookclubListHtml.bind(this));
//   },

//   // Return html for all bookclubs
//   showBookclubListHtml: function(data) {

//     var bookclubs = data.bookclubs;

//     for(var i = 0; i < bookclubs.length; i++) {
//       var bookclub = bookclubs[i];
//       this.bookclubsHtml += this.getBookclubHtml(bookclub);
//     }

//     this.bookclubsHtml += "</ul>";

//     $('.bookclubs-all').prepend(this.bookclubsHtml);

//   },

//   // Return html for one bookclub
//   getBookclubHtml: function(bookclub) {
//     return "<li id='" +
//     bookclub.id.toString() +
//     "'>" +
//     bookclub.name +
//     ": " +
//     bookclub.description +
//     "</li>";
//   },

//   // Request new bookclub creation
//   sendNewBookclubRequest: function(e) {
//     e.preventDefault();

//     var newBook = $(e.target).serialize();

//     var ajaxRequest = $.ajax({
//       url: '/bookclubs',
//       type: 'POST',
//       data: newBook
//     });
//     // when new bookclub is valid, show it on the page
//     ajaxRequest.done(this.showNewBookclub.bind(this));
//     // when new bookclub is invalid, show error message in console log for now
//     ajaxRequest.fail(function(data){
//       console.log(data.responseJSON.message);
//     });
//   },

//   showNewBookclub: function(data) {
//     $('.bookclubs').append(this.getBookclubHtml(data.bookclub));
//     this.formFields().reset();
//   },

//   // Retrieve formFields for reset after submitting
//   formFields: function() {
//     return $('form.new_bookclub')[0];
//   }

// };

//On document load
$(document).ready(function(){
  Users.init();



  
});