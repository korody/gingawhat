Gingawhat::Application.routes.draw do
  
  match '/about',   to: 'pages#about', as: 'about'

  root to: 'pages#home'

end
