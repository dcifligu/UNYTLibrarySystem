class SearchController < ApplicationController
  def index
    @query = params[:query]
    
    if @query.present?
      begin
        @books = Book.search(@query)
        puts "Found #{@books.count} books for query: #{@query}"
        
        @journals = Journal.search(@query)
        puts "Found #{@journals.count} journals for query: #{@query}"
      rescue => e
        puts "Error in search: #{e.message}"
        flash.now[:alert] = "An error occurred while searching."
        @books = []
        @journals = []
      end
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
                  .order(:name) 
    else
      # Show all users if no query is provided
      @users = User.all.order(:name)
    end
    
    # Add debugging info
    puts "Query: #{@query.inspect}"
    puts "Found #{@users.count} users"
    puts "Users: #{@users.map(&:email).inspect}"
  end
  
  private
  
  def authorize_admin
    redirect_to dashboard_path, alert: "Access denied!" unless current_user&.admin?
  end
end