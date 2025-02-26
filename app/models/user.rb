class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    user_type == 0  # Assuming 0 is for admins and 1 is for regular users
  end
end
