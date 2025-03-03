# app/models/fine.rb
class Fine < ApplicationRecord
  belongs_to :loan
  belongs_to :user

  enum :status, { pending: 0, paid: 1 }

  validates :amount, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 500 }
  
  def self.calculate_for_loan(loan)
    return 0 if loan.returned? || loan.end_date >= Date.today
    
    days_overdue = (Date.today - loan.end_date).to_i
    return 0 if days_overdue <= 0
    
    # 50 Lek per day, maximum 500 Lek
    [days_overdue * 50, 500].min
  end
end