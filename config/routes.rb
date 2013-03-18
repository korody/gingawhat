Gingawhat::Application.routes.draw do
  
  match '/contact',   to: 'pages#contact', as: 'contact'

  root to: 'pages#home'

end
