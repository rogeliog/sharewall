Wall::Application.routes.draw do
  resources :links do
    member {post :add_click}
  end
  root to: 'main#index'
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
end
