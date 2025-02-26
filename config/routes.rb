Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    # This acts as a router to the appropriate dashboard
    root "pages#dashboard", as: :authenticated_root
  end

  unauthenticated do
    root "pages#index", as: :unauthenticated_root
  end

  # Generic dashboard route that redirects based on user role
  get "/dashboard", to: "pages#dashboard", as: "dashboard"
  
  # Specific dashboard routes
  get "/user_dashboard", to: "pages#user_dashboard", as: "user_dashboard"
  get "/admin_dashboard", to: "pages#admin_dashboard", as: "admin_dashboard"
end