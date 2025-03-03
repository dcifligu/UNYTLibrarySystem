class MakeLoanIdNullableInFines < ActiveRecord::Migration[8.0]
  def change
    change_column_null :fines, :loan_id, true
  end
end