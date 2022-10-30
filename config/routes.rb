Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  root to: 'users#new'
  #root :to => "tasks#index"
  get "/rechercher" ,to: "tasks#search", as: "tasks_rechercher"
  resources :tasks do
    collection do
      get :sort
      get :search

    end
  end
  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users, except: [:show]
  end
end
