Rails.application.routes.draw do
  root to: 'contact_files#index'
  resources :contact_files, only: %i[index create destroy]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
