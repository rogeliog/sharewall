Wall::Application.routes.draw do
  resources :links
  root to: 'main#index'
end
