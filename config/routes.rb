Rails.application.routes.draw do

  authenticated :user do
    root to: 'tickets#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'tickets#new'
  end

  devise_for :users

  resources :tickets, param: :sub_id do #, constraints: { sub_id: /[A-Z]{3}-[0-9A-F]{2}-[A-Z]{3}-[0-9A-F]{2}-[A-Z]{3}/ }
    resources :ticket_histories, only: :create
  end
end
