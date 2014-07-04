Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root :to => "users#index", as: "home"

  get '/sign_in' => "logging#sign_in"
  get '/sign_out' => "logging#sign_out"
  get '/auth' => "logging#auth" 
end
