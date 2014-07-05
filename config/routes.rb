Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root :to => "users#index", as: "home"

  get '/sign_in' => "logging#sign_in"
  get '/sign_out' => "logging#sign_out"
  get '/auth' => "logging#auth" 

  post '/' => "quotes#search", as: "quote_search"


  get '/quotes/:id' => "quotes#show"

  post '/quotes/:quote_id/comments/create' => "comments#create", as: "new_comment"


  get '/bookclubs' => "bookclubs#index"


  post '/bookclubs/:bookclub_id/quotes/:quote_id' => 'bookclubs#add_quote'


  get '/bookclubs/all' => "bookclubs#all"
  post '/bookclubs' => "bookclubs#create"


end
