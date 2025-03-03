# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    @query = params[:query]
    if @query.present?
      @books = Book.search(@query)
      @journals = Journal.search(@query)
    else
      @books = []
      @journals = []
    end
  end
  
  def users
    authorize_admin
    @query = params[:query]
    if @query.present?
      @users = User.where("name LIKE ? OR surname LIKE ? OR email LIKE ?", 
                          "%#{@query}%", "%#{@query}%", "%#{@query}%")
    else
      @users = []
    end
  end
  
  private
  
  def authorize_admin
    redirect_to dashboard_path, alert: "Access denied!" unless current_user&.admin?
  end
end