Rails.application.routes.draw do
  scope "(:locale)", locale: /en|fr|es|ca/ do
    resources :services, only: [:index, :show, :new, :create] do
      resources :payments, only: [:create]
      get 'payment_success', to: 'payments#success', as: 'payment_success'
      get 'payment_cancel', to: 'payments#cancel', as: 'payment_cancel'
      get 'choose_payment', to: 'payments#choose_payment', as: 'choose_payment'
    end

    resources :payments, only: [:index]

    resources :user_gears, only: [:index, :new, :create, :destroy]

    get 'brands/by_gear_type', to: 'brands#by_gear_type'
    get 'gears/by_brand_and_type', to: 'gears#by_brand_and_type'

    post '/webhooks/stripe', to: 'webhooks#stripe'

    get 'gears_for_brand/:brand_id', to: 'gears#for_brand', as: 'gears_for_brand'

    devise_for :users

    namespace :admin do
      resources :brands
      resources :gears
      resources :services, only: [:index, :show, :update]
      resources :payments, only: [:index]
      resources :users, only: [:index, :show]
      root to: 'dashboard#index'
    end

    root to: 'pages#home'
  end
end
