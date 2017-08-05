Rails.application.routes.draw do
  devise_for :users
  root to:'pages#home'
  get 'about', to: 'pages#about' #Pages controller. About action
  resources :contacts, only: [:create]
  get 'contact-us', to: 'contacts#new', as: 'new_contact' #Change contact-us path to new_contact. 
end
