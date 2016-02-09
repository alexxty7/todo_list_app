Rails.application.routes.draw do
 
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
