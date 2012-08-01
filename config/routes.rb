Going::Application.routes.draw do
	resources :users

  root :to => "home#index" 

	get "login" => "sessions#new", :via => :get
	post "login" => "sessions#create", :via => :post
	get "logout" => "sessions#destroy", :via => :get
end

