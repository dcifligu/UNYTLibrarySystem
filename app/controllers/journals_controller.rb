class JournalsController < ApplicationController
  before_action :authorize_admin, only: [ :create, :new, :destroy ]
  before_action :set_journal, only: [ :details, :reserve, :destroy ]

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params)

    if @journal.save
      redirect_to admin_dashboard_path, notice: "Journal was successfully created."
    else
      render :new
    end
  end

  def index
    @query = params[:query]
    if @query.present?
      @journals = Journal.search(@query)
    else
      @journals = Journal.all
    end
  end

  def details
    # Already set @journal in before_action
  end

  def reserve
    authenticate_user!
    @journal = Journal.find(params[:id])
    @reservable = @journal
    @reservation = current_user.reservations.new(reservable: @journal)
    
    render "reservations/new"
  end

  def destroy
    @journal = Journal.find(params[:id])

    begin
      ActiveRecord::Base.transaction do
        # Handle loans and related fines
        @journal.loans.each do |loan|
          # If there's a fine associated with this loan, handle it first
          if loan.fine.present?
            loan.fine.destroy!
          end

          # Now destroy the loan
          loan.destroy!
        end

        # Then destroy the journal
        @journal.destroy!
      end

      redirect_to journals_path, notice: "Journal was successfully deleted."
    rescue => e
      Rails.logger.error("Error deleting journal: #{e.message}")
      redirect_to journals_path, alert: "Failed to delete journal: #{e.message}"
    end
  end

  private

  def set_journal
    @journal = Journal.find(params[:id])
  end

  def journal_params
    params.require(:journal).permit(:title, :publisher, :issn, :publication_year, :description)
  end

  def authorize_admin
    redirect_to dashboard_path, alert: "Access denied!" unless current_user&.admin?
  end
end
