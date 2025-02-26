Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "pages#dashboard", as: :authenticated_root
  end

  unauthenticated do
    root "pages#index", as: :unauthenticated_root
  end

  get "/dashboard", to: "pages#dashboard", as: "dashboard"
  get "/admin_dashboard", to: "pages#admin_dashboard", as: "admin_dashboard"
  get "/user_dashboard", to: "pages#user_dashboard", as: "user_dashboard"
end
