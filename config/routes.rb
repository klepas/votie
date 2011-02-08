require 'subdomain'

Votie::Application.routes.draw do
  # -- Viewing talks and voting
  constraints(Subdomain) do
    match 'talks/vote' => 'talks#vote', :as => :vote
    match 'talks/presenters' => 'talks#presenters', :as => :presenters
    match 'talks/not_found' => 'talks#not_found', :as => :talk_not_found
    resources :talks

    match 'votes/cast/:id' => 'votes#cast', :as => :cast_vote
    match 'votes/remove/:id' => 'votes#remove', :as => :remove_vote
    
    match '/' => 'talks#index'
  end

  # -- User management
  match   '/signup' => 'users#new',             :as => :user_signup
  match   '/login'  => 'user_sessions#new',     :as => :user_login
  match   '/logout' => 'user_sessions#destroy', :as => :user_logout
  resource :user_session
  resources :users

  # -- Conferences
  resources :conferences
  root :to => 'conferences#index', :as => :home
end
