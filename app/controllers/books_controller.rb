class BooksController < ApplicationController
  before_action :authorize_admin, only: [ :create ]
  def create
  end

  def show
    @books = Book.all
  end

  def details
    @book = Book.find(params[:id])
  end

  def authorize_admin
    redirect_to dashboard_path, alert: "Access denied!" unless current_user.admin?
  end
end
