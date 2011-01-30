Votie::Application.routes.draw do
  match 'votes/cast/:id' => 'votes#cast', :as => :cast_vote
  match 'votes/remove/:id' => 'votes#remove', :as => :remove_vote

  match 'talks/vote' => 'talks#vote', :as => :vote
  match 'talks/presenters' => 'talks#presenters', :as => :presenters
  match 'talks/not_found' => 'talks#not_found', :as => :talk_not_found
  resources :talks

  match   '/signup' => 'users#new',             :as => :signup
  match   '/login'  => 'user_sessions#new',     :as => :login
  match   '/logout' => 'user_sessions#destroy', :as => :logout
  resource :user_session
  resources :users

  root :to => 'talks#index'
end
