Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    root 'static_pages#home'
    get 'static_pages/contact'
    devise_for :users, skip: :omniauth_callbacks,controller: {registrations: "registrations"}
    resources :users, only: [:show]
    resources :categories
    resources :mangas
    resources :chapters
    resources :authors
    namespace :admin do
      root "admin#index",as: :root
      resources :users do
        collection do
          post :import
        end
      end
    end
  end
  match '*.path', to: redirect("/#{I18n.default_locale}/%{path}"), :via => [:get, :post]
  match '', to: redirect("/#{I18n.default_locale}"), :via => [:get, :post]
end
