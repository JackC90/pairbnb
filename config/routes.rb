Rails.application.routes.draw do
  # resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  # resource :session, controller: "clearance/sessions", only: [:create]
  
  # resources :users, controller: "clearance/users", only: [:create] do
  #   resource :password,
  #     controller: "clearance/passwords",
  #     only: [:create, :edit, :update]
  # end

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "auth/facebook", as: "facebook_sign_in"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :listings do
    resources :reservations do
      resources :payments
    end
  end

  resources :users do
    resources :profiles
  end
  
  root to: "welcome#index"
end
