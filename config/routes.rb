Rails.application.routes.draw do
  scope "/:locale", locale: /de|en/ do
    namespace :admin do
      resources :phrases, :users, :searches
      root 'phrases#index'
    end
    resources :searches, :translations, :phrases, :user_sessions, :pages
    resources :users, only: [:new, :create] do
      member do
        get :activate
      end
    end
    get '/sign_up',  to: 'users#new',             as: :sign_up
    get '/sign_in',  to: 'user_sessions#new',     as: :sign_in
    get '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  end

  root 'phrases#index'
  get '/:locale', to: 'pages#index'
end
