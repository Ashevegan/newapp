
#Rails.application.routes.draw do

  #devise_for :users, :controllers => { :registrations => "user_registrations" }
  #resources :products do
    r#esources :comments
  #end
  #resources :users

  get 'static_pages/index'

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/landing_page'

  root 'static_pages#landing_page'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end