class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @reservations = current_user.reservations
  end

  def show
    # @reservation is already set by before_action
  end

  def new
    # This route should typically not be accessed directly
    # But we'll handle it just in case
    @reservation = current_user.reservations.new
    
    # Redirect to books page if they came here directly without specifying an item
    if params[:book_id].present?
      @reservable = Book.find(params[:book_id])
    elsif params[:journal_id].present?
      @reservable = Journal.find(params[:journal_id])
    else
      redirect_to books_path, alert: "Please select an item to reserve first."
    end
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    
    # Find the reservable item for error handling
    if @reservation.reservable_type == "Book"
      @reservable = Book.find(@reservation.reservable_id)
    elsif @reservation.reservable_type == "Journal"
      @reservable = Journal.find(@reservation.reservable_id)
    end
    
    if @reservation.save
      redirect_to reservations_path, notice: "Reservation was successfully created. Awaiting approval."
    else
      render :new
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path, notice: "Reservation was successfully cancelled."
  end

  private

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :notes, :reservable_id, :reservable_type)
  end
end