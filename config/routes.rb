Spinoff::Application.routes.draw do
  namespace :api, path: 'api/v1' do
    resource :company, only: [:create, :show]
  end
end
