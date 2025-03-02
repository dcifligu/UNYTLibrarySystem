class Journal < ApplicationRecord
  has_many :reservations, as: :reservable
  has_many :users, through: :reservations
  
  def available?(start_date, end_date)
    overlapping_reservations = reservations.where(
      "status IN (0, 1) AND NOT (end_date < ? OR start_date > ?)", 
      start_date, end_date
    )
    overlapping_reservations.empty?
  end
end