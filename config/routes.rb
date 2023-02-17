Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
      }
      namespace :auth do
        resources :sessions, only: [:index]
      end
      resources :pharmacies, only: [:index, :show], constraints: { id: /\d+/ } do
        collection do
          post :pharmacy_import
          post :pharmacy_report_import
        end
      end
      resources :reports, only: [:index] do
        collection do
          post :report_import
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
