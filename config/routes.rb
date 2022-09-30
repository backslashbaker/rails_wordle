Rails.application.routes.draw do
  post 'guess', :to => "game#guess"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "game#home"
end
