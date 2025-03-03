# app/controllers/admin/fines_controller.rb
class Admin::FinesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_fine, only: [:update, :destroy]
  
  def index
    @fines = Fine.includes(loan: [:user, :loanable]).order(created_at: :desc)
  end
  
  def new
    @loan = Loan.find(params[:loan_id])
    @fine = Fine.new(loan: @loan, user: @loan.user)
    @amount = Fine.calculate_for_loan(@loan)
  end
  
  def create
    @fine = Fine.new(fine_params)
    
    if @fine.save
      redirect_to admin_fines_path, notice: "Fine was successfully created."
    else
      @loan = @fine.loan
      render :new
    end
  end
  
  def update
    if @fine.update(fine_params)
      redirect_to admin_fines_path, notice: "Fine was successfully updated."
    else
      redirect_to admin_fines_path, alert: "Failed to update fine."
    end
  end
  
  def destroy
    @fine.destroy
    redirect_to admin_fines_path, notice: "Fine was successfully deleted."
  end
  
  private
  
  def set_fine
    @fine = Fine.find(params[:id])
  end
  
  def fine_params
    params.require(:fine).permit(:amount, :status, :loan_id, :user_id)
  end
  
  def authorize_admin
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end