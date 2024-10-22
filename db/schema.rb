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

ActiveRecord::Schema[7.0].define(version: 2024_10_21_083941) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gears", force: :cascade do |t|
    t.string "name"
    t.bigint "brand_id", null: false
    t.integer "gear_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_gears_on_brand_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.integer "status", default: 0
    t.string "stripe_payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount", null: false
    t.index ["service_id"], name: "index_payments_on_service_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "stripe_price_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "product_type", default: 0
    t.integer "price", default: 0, null: false
  end

  create_table "services", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "gear_id", null: false
    t.integer "service_type"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_status", default: 0
    t.index ["gear_id"], name: "index_services_on_gear_id"
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "user_gears", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "gear_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "last_service_date"
    t.index ["gear_id"], name: "index_user_gears_on_gear_id"
    t.index ["user_id"], name: "index_user_gears_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "gears", "brands"
  add_foreign_key "payments", "services"
  add_foreign_key "services", "gears"
  add_foreign_key "services", "users"
  add_foreign_key "user_gears", "gears"
  add_foreign_key "user_gears", "users"
end
