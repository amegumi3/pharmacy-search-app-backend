Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
      }
      namespace :auth do
        resources :sessions, only: [:index]
      end
      resources :pharmacies, only: [:index, :show] do
        collection do
          post :pharmacy_import
          post :pharmacy_report_import
          delete :destroy_all
        end
      end
      post "reports/report_import", to: "reports#report_import"
      delete "reports/destroy_all", to: "reports#destroy_all"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
