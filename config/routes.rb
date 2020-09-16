Rails.application.routes.draw do
  
  root 'home#top'
  get 'home/about' => 'home#about'
  devise_for :users
  
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
