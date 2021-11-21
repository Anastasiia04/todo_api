Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects, only: :show do
        resources :tasks, only: :show do
          resources :comments, only: [:create, :destroy]
        end
      end
    end
  end
end
