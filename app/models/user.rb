class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    user_type == 1  # Assuming 1 is for admins and 0 is for regular users
  end
end
