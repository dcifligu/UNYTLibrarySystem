class CreateLoans < ActiveRecord::Migration[8.0]
  def change
    create_table :loans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :loanable, polymorphic: true, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :status, default: 0
      t.text :notes

      t.timestamps
    end
  end
end
