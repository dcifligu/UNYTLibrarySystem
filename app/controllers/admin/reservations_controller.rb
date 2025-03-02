class Admin::ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  
  def index
    @reservations = Reservation.includes(:user, :reservable).order(created_at: :desc)
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_path, notice: "Reservation status updated successfully."
    else
      redirect_to admin_reservations_path, alert: "Failed to update reservation status."
    end
  end
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:status)
  end
  
  def authorize_admin
    redirect_to root_path, alert: "Access denied!" unless current_user.admin?
  end
end