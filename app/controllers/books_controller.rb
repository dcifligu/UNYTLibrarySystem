class BooksController < ApplicationController
  before_action :authorize_admin, only: [:create]
  before_action :set_book, only: [:details, :reserve]
  
  def create
    # Existing implementation
  end

  def show
    @books = Book.all
  end

  def details
    # Already set @book in before_action
  end
  
  def reserve
    @reservation = @book.reservations.new
  end

  def authorize_admin
    redirect_to dashboard_path, alert: "Access denied!" unless current_user.admin?
  end
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end
end
