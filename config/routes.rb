Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users

  resources :tickets, param: :sub_id #, constraints: { sub_id: /[A-Z]{3}-[0-9A-F]{2}-[A-Z]{3}-[0-9A-F]{2}-[A-Z]{3}/ }
end
