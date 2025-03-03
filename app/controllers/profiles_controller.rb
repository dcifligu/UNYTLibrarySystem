# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  
  def show
  end
  
  def edit
  end
  
  def update
    if current_user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :surname, :contact_address)
  end
end