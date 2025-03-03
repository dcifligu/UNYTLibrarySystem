# app/controllers/admin/reservations_controller.rb (update)
class Admin::ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_reservation, only: [:update, :destroy, :approve, :reject]

  def index
    @reservations = Reservation.includes(:user, :reservable).order(created_at: :desc)
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_path, notice: "Reservation status updated successfully."
    else
      redirect_to admin_reservations_path, alert: "Failed to update reservation status."
    end
  end

  def destroy
    @reservation.destroy
    redirect_to admin_reservations_path, notice: "Reservation was successfully deleted."
  end
  
  def approve
    ActiveRecord::Base.transaction do
      if @reservation.update(status: :approved)
        # Create a loan when reservation is approved
        loan = Loan.new(
          user: @reservation.user,
          loanable: @reservation.reservable,
          start_date: Date.today,
          end_date: Date.today + 14.days,
          status: :active
        )
        
        if loan.save
          @reservation.update(loan: loan)
          redirect_to admin_reservations_path, notice: "Reservation approved and loan created."
        else
          raise ActiveRecord::Rollback
          redirect_to admin_reservations_path, alert: "Failed to create loan: #{loan.errors.full_messages.join(', ')}"
        end
      else
        redirect_to admin_reservations_path, alert: "Failed to approve reservation."
      end
    end
  end
  
  def reject
    if @reservation.update(status: :rejected)
      redirect_to admin_reservations_path, notice: "Reservation rejected."
    else
      redirect_to admin_reservations_path, alert: "Failed to reject reservation."
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:status)
  end

  def authorize_admin
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end