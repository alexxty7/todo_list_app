Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
 
  namespace :api do
    namespace :v1 do
      resources :task_lists
      resources :comments
      resources :tasks do
        patch :sort, on: :member      
      end
    end
  end
end
