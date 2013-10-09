Tits::Application.routes.draw do

  constraints ip: '127.0.0.1' do

    root to: 'images#index'

    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :users,
               controllers: {omniauth_callbacks: 'users/omniauth_callbacks',  registrations: 'registrations'}
    ActiveAdmin.routes(self)

    resources :images do
      resources :comments
      get 'page/:page', action: :index, on: :collection
    end

    resources :comments, only: [:index] do
      get 'page/:page', action: :index, on: :collection
    end

    mount Resque::Server, at: '/resque'

    #get 'categories/:title' => 'categories#show', as: :special_category
    resources :categories, only: [:index, :show] do

    end

    post 'like-up' =>  'likes#create'
    post 'like-down' => 'likes#destroy'
    post 'subscribe' => 'categories#subscribe'
    post 'unsubscribe' => 'categories#unsubscribe'
    post 'more-comments' => 'images#more_comments'

  end

end
