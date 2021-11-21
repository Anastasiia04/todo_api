Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
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
