Rails.application.routes.draw do
  get 'render/index'
  root "render#index"

  #Ajustes
  get 'render/ajustes', to: 'render#ajustes'
  get 'render/perfil', to: 'render#perfil'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # USER

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  

  
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end
end




