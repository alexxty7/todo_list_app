Rails.application.routes.draw do
  root 'home#index'

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      sessions: 'overrides/sessions'
    }

  resources :task_lists, defaults: { format: :json }
  resources :comments, defaults: { format: :json }
  resources :tasks, defaults: { format: :json } do
    patch :sort, on: :member      
  end
end