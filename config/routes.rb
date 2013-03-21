Gingawhat::Application.routes.draw do
    
  resources :cities do
    resources :thumbnails
  end

  resources :posts

  get 'tags/:tag', to: 'posts#index', as: :tag

  match '/blog',   to: 'posts#index', as: 'blog'
  match '/contact',   to: 'pages#contact', as: 'contact'

  root to: 'pages#home'

end
