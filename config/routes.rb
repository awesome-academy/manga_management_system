Rails.application.routes.draw do
  # resources :users, only[:index, :show]
  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations",
                                    omniauth_callbacks: "users/omniauth" }
  devise_scope :user do
    get "sign_up", to: "devise/registrations#new"
    get "edit", to: "devise/registrations#edit"
    get "sign_in", to: "devise/sessions#new"
  end
end
