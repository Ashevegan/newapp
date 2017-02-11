Rails.application.routes.draw do

  resources :products


  get 'static_pages/index'

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/store'


  root 'static_pages#index' 

    

  resources :orders, only: [:index, :show, :create, :destroy]
  end


  
  
# could be changed into root 'products#index' if I wanted the customers directly be directed to the productssection


  #controller :static_pages do
    #get :landing_page
    #get :contact
    #get :about
 


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
