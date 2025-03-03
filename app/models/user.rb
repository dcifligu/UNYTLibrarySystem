# app/models/user.rb (update)
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations, dependent: :destroy
  has_many :loans, dependent: :nullify
  has_many :fines, dependent: :nullify

  has_many :book_reservations, through: :reservations, source: :reservable, source_type: "Book"
  has_many :journal_reservations, through: :reservations, source: :reservable, source_type: "Journal"

  validates :name, :surname, :contact_address, presence: true

  enum :user_type, { regular: 0, admin: 1 }, default: :regular

  def full_name
    "#{name} #{surname}"
  end

  def outstanding_fines_amount
    fines.pending.sum(:amount)
  end

  def has_outstanding_fines?
    outstanding_fines_amount > 0
  end

  def admin?
    user_type == "admin"
  end
end
