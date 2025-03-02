class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reservable, polymorphic: true, null: false
      t.integer :status, default: 0 # 0: pending, 1: approved, 2: rejected, 3: completed
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end