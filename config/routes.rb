Rails.application.routes.draw do
  scope "(:locale)", locale: /en|fr|es|ca/ do
    resources :services, only: [:index, :show, :new, :create] do
      resources :payments, only: [:create]
      get 'payment_success', to: 'payments#success', as: 'payment_success'
      get 'payment_cancel', to: 'payments#cancel', as: 'payment_cancel'
      get 'choose_payment', to: 'payments#choose_payment', as: 'choose_payment'
    end

    post '/webhooks/stripe', to: 'webhooks#stripe'

    get 'gears_for_brand/:brand_id', to: 'gears#for_brand', as: 'gears_for_brand'
    devise_for :users
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")

    root to: 'services#index'

    namespace :admin do
      resources :brands
      resources :gears
      resources :services
      root to: 'dashboard#index'
    end
  end
end
