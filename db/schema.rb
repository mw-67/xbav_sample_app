# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_01_123254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "ctoken", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients_contractors", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "contractor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_clients_contractors_on_client_id"
    t.index ["contractor_id"], name: "index_clients_contractors_on_contractor_id"
  end

  create_table "clients_employees", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_clients_employees_on_client_id"
    t.index ["employee_id"], name: "index_clients_employees_on_employee_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "identity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contractors", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.bigint "partner_company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_company_id"], name: "index_contractors_on_partner_company_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "identifier", null: false
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
  end

  create_table "partner_companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "identity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "clients_contractors", "clients"
  add_foreign_key "clients_contractors", "contractors"
  add_foreign_key "clients_employees", "clients"
  add_foreign_key "clients_employees", "employees"
  add_foreign_key "contractors", "partner_companies"
  add_foreign_key "employees", "companies"
end
