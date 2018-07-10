Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'home#index'

  get '/spotify_login', to: 'users#spotify_intercept'

  get '/auth/spotify/callback', to: 'users#user_mood'

  get '/user/happy', to: 'users#happy'
  get '/user/sad', to: 'users#sad'
  get '/user/moody', to: 'users#moody'

  resources :users

end
