Gingawhat::Application.routes.draw do
    
  get "videos/index"

  get "videos/show"

  get "videos/new"

  get "videos/edit"

  get "users/index"

  get "users/show"

  get "users/new"

  get "users/edit"

  resources :cities do
    resources :thumbnails
  end

  resources :posts do
    resources :attachments
  end

  get 'tags/:tag', to: 'posts#index', as: :tag

  match '/blog',   to: 'posts#index', as: 'blog'
  match '/hello', to: 'contact#new',     as: 'hello',  via: :get
  match '/hello', to: 'contact#create',  as: 'hello',  via: :post

  # root to: 'pages#welcome'
  root to: 'pages#home'

end
