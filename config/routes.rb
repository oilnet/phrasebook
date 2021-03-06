Rails.application.routes.draw do
  root_path = 'phrases#index'

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    resources :pages,         only: [:index, :show]
    resources :phrases,       only: [:index, :show]
    resources :searches,      only: [:index, :create]
    resources :translations,  only: [:show]
    resources :user_sessions, only: [:new, :create]

    resources :users, only: [:new, :create] do
      member do
        get :activate
      end
    end

    get '/sign_up',  to: 'users#new',             as: :sign_up
    get '/sign_in',  to: 'user_sessions#new',     as: :sign_in
    get '/sign_out', to: 'user_sessions#destroy', as: :sign_out
    
    namespace :admin do
      resources :users, :searches, :tags, :phrases
      root to: root_path 
    end
  end

  root to: root_path 
  get '/:locale', to: root_path

  # Any other routes are handled here (as ActionDispatch prevents RoutingError from hitting ApplicationController::rescue_action)
  # http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
  match "*path", to: "application#routing_error", via: :all
end
