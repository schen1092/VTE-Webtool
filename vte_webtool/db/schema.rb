# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150507052736) do

  create_table "compliances", force: :cascade do |t|
    t.date     "date"
    t.float    "result"
    t.integer  "provider_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "compliances", ["provider_id"], name: "index_compliances_on_provider_id"

  create_table "orders", force: :cascade do |t|
    t.string   "PATIENT_NAME"
    t.integer  "VISITID"
    t.string   "ORDERSET_KEY"
    t.string   "JHH_SERVICE"
    t.string   "MEDICATION_COMPLIANCE"
    t.integer  "provider_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.date     "ORD_DT"
    t.date     "ADMISSION_DATE"
    t.string   "CAT_NAME"
    t.integer  "CAT_CODE"
    t.string   "HISTORY_NO"
  end

  add_index "orders", ["provider_id"], name: "index_orders_on_provider_id"

  create_table "providers", force: :cascade do |t|
    t.string   "ORDERING_PROVIDER"
    t.string   "ORDERING_PROV_JHED_ID"
    t.string   "ORDERING_PROVIDER_ROLE"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visits", force: :cascade do |t|
    t.integer  "visit_id"
    t.date     "date"
    t.integer  "provider_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "visits", ["provider_id"], name: "index_visits_on_provider_id"

end
