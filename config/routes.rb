# config/routes.rb (update)
Rails.application.routes.draw do
  get "journals/show"
  get "journals/create"
  get "books/create"
  get "books/show"
  devise_for :users
  
  # Search routes
  get '/search', to: 'search#index', as: 'search'
  get '/search/users', to: 'search#users', as: 'search_users'
  
  # Profile routes
  get '/profile', to: 'profiles#show', as: 'profile'
  get '/profile/edit', to: 'profiles#edit', as: 'edit_profile'
  patch '/profile', to: 'profiles#update'
  
  resources :books, only: [:index, :show, :create, :new] do
    member do
      get :details
      get :reserve
    end
    resources :reservations, only: [:new, :create]
  end

  resources :journals, only: [:index, :show, :create, :new] do
    member do
      get :details
      get :reserve
    end
    resources :reservations, only: [:new, :create]
  end

  resources :reservations, only: [:index, :show, :destroy]

  authenticated :user do
    root "pages#dashboard", as: :authenticated_root
  end

  unauthenticated do
    root "pages#index", as: :unauthenticated_root
  end

  namespace :admin do
    resources :reservations, only: [:index, :update, :destroy] do
      member do
        patch :approve
        patch :reject
      end
    end
    
    resources :loans, only: [:index, :new, :create, :show] do
      member do
        patch :close
      end
    end
    
    resources :fines, only: [:index, :new, :create, :update, :destroy]
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