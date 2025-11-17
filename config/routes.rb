Rails.application.routes.draw do
   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  resource :session
  resources :passwords, param: :token
  resources :users, only: %i[ new create ]
  
  resources :clients, shallow: true do
    resources :appointments do
      resources :notes, except: [ :index ]
    end
  end

  root to: "clients#index"
end
