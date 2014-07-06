// Main script for /bookclubs
var Bookclubs = {

  // Finds the current user's id
  currentUserId: function() { return parseInt($('div.bookclubs-all').attr('data-current-user')); },

  // Bind events to Bookclubs
  bind: function() {
    $('.new_bookclub').on('submit', this.sendNewBookclubRequest.bind(this));
  },

  init: function(model) {
    this.bind();
    this.renderList();
  },

  // Render list of bookclubs
  renderList: function() {
    // Fetch bookclubs on load
    var ajaxRequest = $.ajax({
          url: '/bookclubs/all',
          type: 'GET'
        });
    ajaxRequest.done(this.showBookclubListHtml.bind(this));
  },

  // Prepare bookclubs list HTML
  bookclubsHtml: "<ul class='bookclubs'>",

  // Return html for all bookclubs
  showBookclubListHtml: function(data) {
    var bookclubs = data.bookclubs;
    for(var i = 0; i < bookclubs.length; i++) {
      var bookclub = bookclubs[i];
      this.bookclubsHtml += this.getBookclubHtml(bookclub, this.currentUserId());
    }

    this.bookclubsHtml += "</ul>";

    $('.bookclubs-all').prepend(this.bookclubsHtml);

  },

  // Return html for one bookclub
  getBookclubHtml: function(bookclub, currentUserId) {
    // If current user is not in the bookclub,
    // add a + so that the user can join the bookclub
    var joinBookclub = "";
    if ($.inArray(currentUserId, bookclub.user_ids) == -1) {
      joinBookclub = "<button class='join-bookclub'>+</button>";
    }

    // If current user is the admin of the bookclub,
    // add a bookclub-admin class to the li
    var adminBookclub = "";
    if (currentUserId == bookclub.admin_id) {
      adminBookclub = "class='bookclub-admin'";
    }

    var html = "<li id='" +
                bookclub.id.toString() +
                "'" +
                adminBookclub +
                ">" +
                bookclub.name +
                ": " +
                bookclub.description +
                joinBookclub +
                "</li>";  

    return html;
  },

  // Request new bookclub creation
  sendNewBookclubRequest: function(e) {
    e.preventDefault();

    var newBook = $(e.target).serialize();

    var ajaxRequest = $.ajax({
      url: '/bookclubs',
      type: 'POST',
      data: newBook
    });
    // when new bookclub is valid, show it on the page
    ajaxRequest.done(this.showNewBookclub.bind(this));
    // when new bookclub is invalid, show error message in console log for now
    ajaxRequest.fail(function(data){
      console.log(data.responseJSON.message);
    });
  },

  showNewBookclub: function(data) {
    $('.bookclubs').append(this.getBookclubHtml(data.bookclub));
    this.formFields().reset();
  },

  // Retrieve formFields for reset after submitting
  formFields: function() {
    return $('form.new_bookclub')[0];
  }

};

//On document load
$(document).ready(function(){
  Bookclubs.init();
});