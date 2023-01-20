Rails.application.routes.draw do
  #get 'sessions/new'
  root to: 'users#new'
  #resources :tasks
  resources :users, only: %i[new create show]
  resources :sessions, only: %i[new create destroy]
  resources :labels, only: %i[new create]
  #root :to => "tasks#index"
  get "/rechercher" ,to: "tasks#search", as: "tasks_rechercher"
  resources :tasks do
    collection do
      get :sort
      get :search

    end
  end
  namespace :admin do
    resources :users, except: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
