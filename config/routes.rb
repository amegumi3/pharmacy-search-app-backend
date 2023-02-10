Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :pharmacies do
        collection do
          post :import
        end
      end
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
      }
      namespace :auth do
        resources :sessions, only: [:index]
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
