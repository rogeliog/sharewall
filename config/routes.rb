Wall::Application.routes.draw do
  resources :links do
    member {post :add_click}
  end
  root to: 'main#index'
end
