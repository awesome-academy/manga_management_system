Rails.application.routes.draw do
  get 'events/index'
  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    root 'static_pages#home'
    get 'static_pages/contact'
    get "search(/:search)", to: "searches#index", as: :search
    devise_for :users, skip: :omniauth_callbacks,controller: {registrations: "registrations"}
    resources :users, only: [:show] do
      member do
        get :following
      end
    end
    resources :categories
    resources :mangas do
      resources :comments,only: [:create, :destroy]
      member do
        get :followers
      end
      resources :vote_mangas, only: [:create, :destroy]
    end
    resources :chapters do
      resources :votes,only: [:create,:destroy]
    end
    resources :authors
    resources :relationships, only: [:create, :destroy]
    resources :searches, only: :index
    resources :events, only: [:index]
    namespace :admin do
      root "admin#index",as: :root
      resources :categories
      resources :mangas
      resources :chapters
      resources :animes
      resources :users do
        collection do
          post :import
        end
      end
    end
    mount ActionCable.server => '/cable'
  end
  match '*.path', to: redirect("/#{I18n.default_locale}/%{path}"), :via => [:get, :post]
  match '', to: redirect("/#{I18n.default_locale}"), :via => [:get, :post]
  match "*path" => redirect("/"), via: :get
end
