Rails.application.routes.draw do
  root to:'pages#home'
  devise_for :users, controllers: {registrations: 'users/registrations'}  #Extend functionality. Make registrations_controller seperately.
  resources :users do #User'S' have ONE profile. Plural then singular.
    resource :profile
  end
  get 'about', to: 'pages#about' #Pages controller. About action
  resources :contacts, only: [:create]
  get 'contact-us', to: 'contacts#new', as: 'new_contact' #Change contact-us path to new_contact. 
end
