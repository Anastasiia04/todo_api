Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[create]
      resource :login, only: %i[create]
      resource :refresh, only: %i[create]
      resources :projects, except: :show do
        resources :tasks, shallow: true, except: :show do
          member do
            patch :complete
          end
          resources :comments, only: %i[create destroy]
        end
      end
    end
  end
end
