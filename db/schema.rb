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

ActiveRecord::Schema.define(version: 20220203133327) do

  create_table "customer_additional_infos", force: :cascade do |t|
    t.integer  "customer_entity_id", limit: 4
    t.date     "birthday"
    t.date     "anniversary"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "customer_entities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "mobile",     limit: 20
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "customer_entities", ["email"], name: "index_customer_entities_on_email", unique: true, using: :btree

  create_table "sales_flat_coupons", force: :cascade do |t|
    t.integer  "customer_entity_id", limit: 4
    t.string   "coupon",             limit: 255
    t.integer  "coupon_type",        limit: 4
    t.boolean  "is_active"
    t.boolean  "is_used"
    t.date     "expiry"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
