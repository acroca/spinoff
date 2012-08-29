Spinoff::Application.routes.draw do
  devise_for :users

  root to: 'home#index'
  get "game" => 'game#show', as: :game

  namespace :api, path: 'api/v1' do
    resources :companies, only: [:show]
  end
end
