# app/controllers/reservations_controller.rb (update)
class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservable, only: [ :new, :create ]

  def index
    @reservations = current_user.reservations.includes(:reservable)
    @loans = current_user.loans.includes(:loanable)
    @fines = current_user.fines.includes(:loan)
  end

  def new
    @reservation = @reservable.reservations.new
  end

  def create
    @reservation = @reservable.reservations.new(reservation_params)
    @reservation.user = current_user
    @reservation.start_date ||= Date.today
    @reservation.end_date ||= @reservation.start_date + 2.hours

    if @reservation.save
      redirect_to reservations_path, notice: "Reservation was successfully created. Awaiting approval."
    else
      render :new
    end
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: "Reservation was successfully cancelled."
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  end

  private

  def set_reservable
    if params[:book_id]
      @reservable = Book.find(params[:book_id])
    elsif params[:journal_id]
      @reservable = Journal.find(params[:journal_id])
    end
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end