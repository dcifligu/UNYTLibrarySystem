class BooksController < ApplicationController
  before_action :authorize_admin, only: [ :create, :new, :destroy ]
  before_action :set_book, only: [ :details, :reserve, :destroy ]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to admin_dashboard_path, notice: "Book was successfully created."
    else
      render :new
    end
  end

  def index
    @query = params[:query]
    if @query.present?
      @books = Book.search(@query)
    else
      @books = Book.all
    end
  end

  def details
    # Already set @book in before_action
  end

  def reserve
    authenticate_user!
    @book = Book.find(params[:id])
    @reservable = @book
    @reservation = current_user.reservations.new(reservable: @book)
    
    render "reservations/new"
  end

  def destroy
    @book = Book.find(params[:id])

    begin
      ActiveRecord::Base.transaction do
        # Handle loans and related fines
        @book.loans.each do |loan|
          # If there's a fine associated with this loan, handle it first
          if loan.fine.present?
            # Either destroy the fine
            loan.fine.destroy!
            # Or detach it from the loan (set loan_id to nil)
            # loan.fine.update!(loan_id: nil)
          end

          # Now destroy the loan
          loan.destroy!
        end

        # Then destroy the book
        @book.destroy!
      end

      redirect_to books_path, notice: "Book was successfully deleted."
    rescue => e
      Rails.logger.error("Error deleting book: #{e.message}")
      redirect_to books_path, alert: "Failed to delete book: #{e.message}"
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :publication_year, :description)
  end

  def authorize_admin
    redirect_to dashboard_path, alert: "Access denied!" unless current_user&.admin?
  end
end
