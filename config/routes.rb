Rails.application.routes.draw do
  scope "/:locale", locale: /de|en/ do
    resources :searches
    resources :translations
    resources :phrases
    
    resources :users, only: [:new, :create] do
      member do
        get :activate
      end
    end
    resources :user_sessions
    
    get '/sign_up',  to: 'users#new',             as: :sign_up
    get '/sign_in',  to: 'user_sessions#new',     as: :sign_in
    get '/sign_out', to: 'user_sessions#destroy', as: :sign_out
    
    resources :pages
  end

  root 'pages#index'
  get '/:locale', to: 'pages#index'
end
