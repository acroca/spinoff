Spinoff::Application.routes.draw do
  devise_for :users

  root to: 'home#index'
  get "game" => 'game#show', as: :game

  namespace :api, path: 'api/v1' do
    resources :companies, only: [:show] do
      member do
        get 'programs' => 'programs#company_programs'
      end
    end
    resources :programs, only: [:index, :show, :update]
    resources :slots, only: [:create, :index, :show]
  end
end
