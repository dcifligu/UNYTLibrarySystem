class JournalsController < ApplicationController
  before_action :authorize_admin, only: [ :create ]
  def show
    @journals = Journal.all
  end

  def details
    @journal = Journal.find(params[:id])
  end
  def create
  end
end
