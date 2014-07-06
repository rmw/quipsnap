Rails.application.routes.draw do
	mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

	root :to => "users#index", as: "home"

	get '/sign_in' => "logging#sign_in"
	get '/sign_out' => "logging#sign_out"
	get '/auth' => "logging#auth" 

  get '/quotes/:id' => "quotes#show"
	post '/' => "quotes#search", as: "quote_search"

  post '/quotes/:quote_id/comments/create' => "comments#create", as: "new_comment"
	post '/quotes/comments/:comment_id/create' => "comments#create", as: "new_comment_reply"
	get '/comments/replies' => "comments#get_replies"

	get '/bookclubs' => "bookclubs#index"
  post '/bookclubs' => "bookclubs#create"
  get '/bookclubs/all' => "bookclubs#all"
	post '/bookclubs/:bookclub_id/quotes/:quote_id' => 'bookclubs#add_quote'
  get '/bookclubs/:bookclub_id' => 'bookclubs#show', as: "show_bookclub"
  put '/bookclubs/join' => "bookclubs#join"

end
