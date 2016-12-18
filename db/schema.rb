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

ActiveRecord::Schema.define(version: 20140524044425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "item_code"
    t.string   "description"
    t.float    "real_price"
    t.float    "variable_cost_percent"
    t.float    "cost_price"
    t.float    "sale_price"
    t.float    "quantity",              default: 0.0, null: false
    t.float    "quantity_godown",       default: 0.0, null: false
    t.float    "quantity_shop",         default: 0.0
    t.float    "profit_on_stock"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "cost_at_supplier"
    t.float    "exchange_rate"
  end

  create_table "sales", force: true do |t|
    t.integer  "product_id"
    t.text     "product_code"
    t.string   "description"
    t.float    "quantity",     default: 0.0
    t.float    "sold_price"
    t.float    "profit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
