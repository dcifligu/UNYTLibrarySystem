class Fine < ApplicationRecord
  belongs_to :user
  belongs_to :loan, optional: true # Keep this as optional to be safe
  
  enum :status, { pending: 0, paid: 1 }, default: :pending
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  
  def self.calculate_for_loan(loan)
    return 0 unless loan.overdue?
    days = loan.days_overdue
    rate = 0.50 # $0.50 per day
    days * rate
  end
end