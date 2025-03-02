class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :reservable, polymorphic: true

  enum :status, { pending: 0, approved: 1, rejected: 2, completed: 3 }

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :dates_not_in_past
  validate :item_available, on: :create

  private

  def end_date_after_start_date
    if start_date && end_date && end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def dates_not_in_past
    if start_date && start_date < Date.today
      errors.add(:start_date, "cannot be in the past")
    end
  end

  def item_available
    unless reservable.available?(start_date, end_date)
      errors.add(:base, "The selected item is not available for the requested dates")
    end
  end
end
