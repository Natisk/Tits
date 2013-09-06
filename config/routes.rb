Tits::Application.routes.draw do

  root to: 'categories#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  ActiveAdmin.routes(self)

  resources :images do
    resources :comments
  end

  get 'categories' => 'categories#index'
  get 'categories/:title' => 'categories#show', as: :special_category
  get 'comments' => 'comments#index', as: :comments

end
