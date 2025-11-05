Rails.application.routes.draw do
  get "appointments/index"
  get "appointments/new"
  get "appointments/create"
  get "appointments/edit"
  get "appointments/update"
  get "appointments/destory"
  get "clients/index"
  get "clients/show"
  get "clients/new"
  get "clients/create"
  get "clients/edit"
  get "clients/update"
  get "clients/destroy"
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  resources :clients do
    resources :appointments, only: [:new, :create, :edit, :update, :destroy]
  end

  root to: "clients#index"
end
