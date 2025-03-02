class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :reservations
  has_many :book_reservations, through: :reservations, source: :reservable, source_type: 'Book'
  has_many :journal_reservations, through: :reservations, source: :reservable, source_type: 'Journal'

  def admin?
    user_type == 1  # Assuming 1 is for admins and 0 is for regular users
  end
end