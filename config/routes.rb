Spinoff::Application.routes.draw do

  devise_for :users

  root to: 'home#index'

  namespace :api, path: 'api/v1' do
    resources :companies, only: [:create, :show]
  end
end
