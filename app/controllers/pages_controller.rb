class PagesController < ApplicationController
  include Devise::Controllers::Helpers # Add this if missing
  before_action :authenticate_user!

  def index
    redirect_to dashboard_path if user_signed_in?
  end

  def dashboard
  end
end
