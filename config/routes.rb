Rails.application.routes.draw do
  get 'pages/index'
  root 'pages#index'

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/products'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
