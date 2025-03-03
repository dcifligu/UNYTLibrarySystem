module Admin
  class LoansController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin
    before_action :set_loan, only: [:show, :close]

    def index
      @loans = Loan.includes(:user, :loanable)
      @loans = case params[:filter]
      when "past"
                 @loans.past
      when "overdue"
                 @loans.overdue
      when "outstanding"
                 @loans.outstanding
      else
                 @loans
      end
    end

    def new
      @loan = Loan.new
      if params[:book_id]
        @loanable = Book.find(params[:book_id])
      elsif params[:journal_id]
        @loanable = Journal.find(params[:journal_id])
      end
      @users = User.where(user_type: 0)
    end

    def create
      @loan = Loan.new(loan_params)
      @loan.start_date = Date.today
      @loan.end_date = Date.today + 14.days

      if @loan.save
        redirect_to admin_loans_path, notice: "Loan created successfully."
      else
        @users = User.where(user_type: 0)
        render :new
      end
    end

    def show
      @fine_amount = Fine.calculate_for_loan(@loan)
    end

    def close
      if @loan.update(status: :returned)
        if @loan.overdue? && @fine_amount > 0
          fine = @loan.build_fine(
            user: @loan.user,
            amount: @fine_amount,
            status: params[:collect_fine] == "1" ? :paid : :pending
          )
          fine.save
        end
        redirect_to admin_loans_path, notice: "Loan closed successfully."
      else
        redirect_to admin_loans_path, alert: "Failed to close loan."
      end
    end
    
    # New method for dynamically loading loanable items
    def get_loanables
      type = params[:type]
      
      items = case type
      when "Book"
        Book.all
      when "Journal"
        Journal.all
      else
        []
      end
      
      render json: items.map { |item| { id: item.id, title: item.title } }
    end

    private

    def set_loan
      @loan = Loan.find(params[:id])
      @fine_amount = Fine.calculate_for_loan(@loan)
    end

    def loan_params
      params.require(:loan).permit(:user_id, :loanable_id, :loanable_type)
    end

    def authorize_admin
      redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
    end
  end
end