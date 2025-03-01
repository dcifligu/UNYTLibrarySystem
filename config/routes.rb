Rails.application.routes.draw do
  get "journals/show"
  get "journals/create"
  get "books/create"
  get "books/show"
  devise_for :users
  resources :books, only: [ :show, :create ] do
    member do
      get :details
    end
  end
  resources :journals, only: [ :show, :create ] do
    member do
      get :details
    end
  end
  authenticated :user do
    root "pages#dashboard", as: :authenticated_root
  end

  unauthenticated do
    root "pages#index", as: :unauthenticated_root
  end

  get "/dashboard", to: "pages#dashboard", as: "dashboard"
  get "/admin_dashboard", to: "pages#admin_dashboard", as: "admin_dashboard"
  get "/user_dashboard", to: "pages#user_dashboard", as: "user_dashboard"
  get "/about_us", to: "pages#about_us", as: "about_us"
  get "/journals", to: "journals#show", as: "show_journals"
  get "/journals/new", to: "journals#create", as: "create_journals"
  get "/books", to: "books#show", as: "show_books"
  get "/books/new", to: "books#create", as: "create_books"
end
