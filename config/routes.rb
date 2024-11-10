Rails.application.routes.draw do
  get 'render/index'
  root "render#index"

  #Ajustes
  get 'render/ajustes', to: 'render#ajustes'
  get 'render/perfil', to: 'render#perfil'

  # Idea de ver clases
  get 'enrolled_courses', to: 'courses#my_courses', as: 'enrolled_courses'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  resources :posts

  # USER
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :courses do
    # Rutas para enrollment_requests
    resources :enrollment_requests, only: [:index, :create] do
      member do
        patch :approve
        patch :reject
        get :participants
        get :show
        get :visitantes
      end
    end

    # Rutas para evaluations
    resources :evaluations do
      member do
        get :edit
        patch :update
        delete :destroy
        get 'student_results'
        post 'update_grade'
        get 'show_answer'
        post 'save_answer'
        post 'grade_question/:question_id', to: 'evaluations#grade_question', as: 'grade_question'
        post 'save_changes'
        post 'submit'
      end
    end

    # Rutas para reviews
    resources :reviews

    # Member routes para courses
    member do
      delete :leave
      get 'student_evaluations'

      #Archivos clase
      get 'form_documents', to: 'courses#form_documents'
      patch 'upload_documents', to: 'courses#upload_documents'
      get 'form_subir_documents', to: 'courses#form_subir_documents'
      patch 'subir_documents', to: 'courses#subir_documents'
      delete 'courses/:id/eliminar_documents.:blob_id', to: 'courses#eliminar_documents', as: 'eliminar_documents'
      get 'foro', to: 'chats#foro', as: 'foro'
      post 'crear_mensaje', to: 'chats#crear_mensaje'
      get 'visitantes', to: 'courses#visitantes'
    end
  end

  # Ruta para ver las clases dictadas por el profesor
  get 'taught_classes', to: 'courses#taught_classes', as: 'taught_classes'
  get '/my_courses', to: 'courses#my_courses', as: 'my_courses'
  get '/available_courses', to: 'courses#available_courses', as: 'available_courses'

  authenticated :user do
    get 'profile', to: 'users#profile', as: 'profile'
  end

  # Ruta para el perfil de usuario autenticado
  get 'visitantes', to: 'courses#visitantes'

end
