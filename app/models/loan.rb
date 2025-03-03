# app/models/loan.rb
class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :loanable, polymorphic: true
  has_one :fine, dependent: :destroy

  enum :status, { active: 0, returned: 1, overdue: 2 }, default: :active


  scope :outstanding, -> { where(status: [ :active, :overdue ]) }
  scope :overdue, -> { where(status: :overdue) }
  scope :past, -> { where(status: :returned) }

  before_create :set_default_end_date

  def overdue?
    end_date < Date.today && !returned?
  end

  def days_overdue
    return 0 unless overdue?
    (Date.today - end_date).to_i
  end

  private

  def set_default_end_date
    self.end_date ||= start_date + 14.days # Default loan period is 2 weeks
  end
end
