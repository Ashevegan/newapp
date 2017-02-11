Rails.application.routes.draw do

  resources :products
  resources :products 
    

  get 'static_pages/index'

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/store'

  


  resources :orders, only: [:index, :show, :create, :destroy]
  end

  

  root 'static_pages#landing_page'

  controller :static_pages do
    get :landing_page
    get :contact
    get :about
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
