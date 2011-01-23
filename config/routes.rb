Votie::Application.routes.draw do
  match 'votes/cast/:id' => 'votes#cast', :as => :cast_vote
  match 'votes/remove/:id' => 'votes#remove', :as => :remove_vote

  match 'talks/vote' => 'talks#vote', :as => :vote
  match 'talks/presenters' => 'talks#presenters', :as => :presenters
  match 'talks/not_found' => 'talks#not_found', :as => :talk_not_found
  resources :talks

  match 'users/login' => 'users#login', :as => :user_login
  match 'users/login/dev' => 'users#login_dev', :as => :user_login_dev
  match 'users/callback' => 'users#callback'
  match 'users/logout' => 'users#logout', :as => :user_logout
  resources :users

  match '/' => 'talks#index'
  #match '/:controller(/:action(/:id))'
end
