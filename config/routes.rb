# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  devise_for :users,
             path: '',
             defaults: { format: :json },
             path_names: {
               sign_in: 'api/login',
               sign_out: 'api/logout',
               registration: 'api/signup'
             },
             controllers: {
               sessions: 'api/sessions',
               registrations: 'api/registrations'
             }

  # ============ API ============

  namespace :api, defaults: { format: 'json' } do
    resources :positions, only: [:create]
    resources :trips, only: %i[index]
    resources :routes, only: %i[index]
  end
  # ============ end API ============

  # Defines the root path route ("/")
  # root "posts#index"
end
