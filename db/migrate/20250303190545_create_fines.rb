class CreateFines < ActiveRecord::Migration[8.0]
  def change
    create_table :fines do |t|
      t.references :loan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.integer :status, default: 0
      t.text :notes

      t.timestamps
    end
  end
end