# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_03_224355) do
  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "language"
    t.string "publisher"
    t.integer "publish_year"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fines", force: :cascade do |t|
    t.integer "loan_id"
    t.integer "user_id", null: false
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.integer "status", default: 0
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_fines_on_loan_id"
    t.index ["user_id"], name: "index_fines_on_user_id"
  end

  create_table "journals", force: :cascade do |t|
    t.string "title"
    t.integer "volume"
    t.integer "issue"
    t.string "language"
    t.string "publisher"
    t.integer "publish_year"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "loanable_type", null: false
    t.integer "loanable_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "status", default: 0
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loanable_type", "loanable_id"], name: "index_loans_on_loanable"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "reservable_type", null: false
    t.integer "reservable_id", null: false
    t.integer "status", default: 0
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservable_type", "reservable_id"], name: "index_reservations_on_reservable"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "surname", null: false
    t.string "contact_address"
    t.integer "user_type", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "fines", "loans"
  add_foreign_key "fines", "users"
  add_foreign_key "loans", "users"
  add_foreign_key "reservations", "users"
end
