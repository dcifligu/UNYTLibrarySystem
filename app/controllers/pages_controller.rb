class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def index
  end

  def about_us
  end

  def dashboard
    if current_user.admin?
      redirect_to admin_dashboard_path
    else
      redirect_to user_dashboard_path
    end
  end

  def admin_dashboard
  end

  def user_dashboard
  end
end
