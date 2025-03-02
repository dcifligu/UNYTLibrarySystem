class JournalsController < ApplicationController
  before_action :authorize_admin, only: [ :create ]
  before_action :set_journal, only: [ :details, :reserve ]

  def show
    @journals = Journal.all
  end

  def details
    # Already set @journal in before_action
  end

  def create
    # Existing implementation
  end

  def reserve
    @reservation = @journal.reservations.new
  end

  private

  def set_journal
    @journal = Journal.find(params[:id])
  end

  def authorize_admin
    redirect_to dashboard_path, alert: "Access denied!" unless current_user.admin?
  end
end
