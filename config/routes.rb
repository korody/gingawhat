Gingawhat::Application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :cities do
    resources :attachments
  end

  resources :posts do
    resources :attachments
    resources :tags
  end

  resources :users do
    resources :attachments
  end
    
  resources :idealizadores, path: 'idealizadores', controller: :users
  resources :colaboradores, path: 'colaboradores', controller: :users
  resources :participantes, path: 'participantes', controller: :users
  resources :parceiros, path: 'parceiros', controller: :users

  resources :videos
  
  resources :programas, path: 'programas', controller: :videos
  resources :teasers, path: 'teasers', controller: :videos
  resources :pessoas, path: 'pessoas', controller: :videos
  resources :makingof, path: 'makingof', controller: :videos

  resources :sessions    
  resources :password_resets

  get 'tags/:tag', to: 'posts#index', as: :tag

  match '/blog',   to: 'posts#index', as: 'blog'
  match '/hello', to: 'contact#new',     as: 'hello',  via: :get
  match '/hello', to: 'contact#create',  as: 'hello',  via: :post

  # root to: 'pages#welcome'
  root to: 'pages#home'

end
