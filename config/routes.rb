Rails.application.routes.draw do

  
  resources :products do
  resources :comments
  end

  resources :users
  resources :orders, only: [:index, :show, :create, :destroy]

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}, :controllers => { :registrations => "user_registrations" }




   get 'static_pages/landing_page'

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/store'

   post 'static_pages/thank_you'


  root 'static_pages#landing_page' 

    

  end


  
  
# could be changed into root 'products#index' if I wanted the customers directly be directed to the productssection


  #controller :static_pages do
    #get :landing_page
    #get :contact
    #get :about
 


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
