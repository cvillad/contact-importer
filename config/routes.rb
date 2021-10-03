Rails.application.routes.draw do
  root to: 'contact_files#index'
  resources :contact_files, only: %i[index create destroy] do
    resource :import, only: %i[new create], controller: 'contact_files/imports'
  end
  resources :contacts, only: :index
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
