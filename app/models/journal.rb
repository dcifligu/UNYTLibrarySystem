# app/models/journal.rb (update)
class Journal < ApplicationRecord
  has_many :reservations, as: :reservable, dependent: :destroy
  has_many :loans, as: :loanable, dependent: :destroy
  has_many :users, through: :reservations

  validates :title, :publisher, presence: true

  def available?(start_date = Date.today, end_date = nil)
    # Check for active reservations
    reservation_query = reservations.where(
      "status IN (0, 1) AND NOT (end_date < ? OR start_date > ?)",
      start_date, end_date || start_date
    )

    # Check for active loans
    loan_query = loans.where(
      "status IN (0, 2) AND NOT (end_date < ?)",
      start_date
    )

    reservation_query.empty? && loan_query.empty?
  end

  def current_status
    active_loan = loans.where(status: [ :active, :overdue ]).first
    active_reservation = reservations.where(status: [ :pending, :approved ]).first

    if active_loan
      active_loan.overdue? ? "On loan (overdue)" : "On loan"
    elsif active_reservation
      "Reserved"
    else
      "Available"
    end
  end

  def self.search(query)
    where("title LIKE ? OR publisher LIKE ? OR description LIKE ?", 
          "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
