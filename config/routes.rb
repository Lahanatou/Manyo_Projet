Rails.application.routes.draw do
  resources :tasks
  root :to => "tasks#index"
  get "/rechercher" ,to: "tasks#search", as: "tasks_rechercher"
  resources :tasks do
    collection do
      get :sort
      get :search

    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
