# app/controllers/pages_controller.rb (update)
class PagesController < ApplicationController
  before_action :authenticate_user!, only: [ :dashboard, :user_dashboard, :admin_dashboard ]

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
    redirect_to user_dashboard_path unless current_user.admin?
    @pending_reservations = Reservation.where(status: :pending).count
    @overdue_loans = Loan.overdue.count
    @total_users = User.where(user_type: 0).count
    @total_books = Book.count
    @total_journals = Journal.count
    @recent_loans = Loan.order(created_at: :desc).limit(5)
  end

  def user_dashboard
    @reservations = current_user.reservations.where(status: [ :pending, :approved ]).includes(:reservable)
    @active_loans = current_user.loans.where(status: [ :active, :overdue ]).includes(:loanable)
    @pending_fines = current_user.fines.where(status: :pending)
  end
end
