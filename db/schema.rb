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

ActiveRecord::Schema[7.0].define(version: 2023_06_11_113351) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "connection_id"
    t.string "remote_id"
    t.string "name"
    t.string "nature"
    t.decimal "balance", precision: 15, scale: 5
    t.string "currency_code"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connection_id"], name: "index_accounts_on_connection_id"
  end

  create_table "connect_sessions", force: :cascade do |t|
    t.bigint "customer_id"
    t.datetime "expires_at"
    t.string "connect_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_connect_sessions_on_customer_id"
  end

  create_table "connections", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "remote_id"
    t.jsonb "response"
    t.string "country_code"
    t.datetime "last_success_at"
    t.datetime "next_refresh_possible_at"
    t.string "provider_id"
    t.string "provider_code"
    t.string "provider_name"
    t.string "status"
    t.boolean "removed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_connections_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "remote_id"
    t.string "identifier"
    t.string "secret"
    t.datetime "blocked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "account_id"
    t.string "remote_id"
    t.boolean "duplicated", default: false
    t.string "mode"
    t.string "status"
    t.date "made_on"
    t.decimal "amount", precision: 15, scale: 5
    t.string "currency_code"
    t.string "description"
    t.string "category"
    t.jsonb "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
