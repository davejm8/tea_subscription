Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers do
        resources :subscriptions, only: [:index, :create, :update]
      end

      resources :teas
    end
  end
end
