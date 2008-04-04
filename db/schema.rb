# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "buildings", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on", :null => false
    t.datetime "updated_on", :null => false
  end

  create_table "features", :force => true do |t|
    t.string   "name"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "groups", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_on", :null => false
    t.datetime "updated_on", :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "amount",                         :null => false
    t.integer  "price",                          :null => false
    t.integer  "folio",                          :null => false
    t.text     "description",                    :null => false
    t.string   "provider_id",                    :null => false
    t.boolean  "status",      :default => false, :null => false
    t.integer  "moduser_id"
    t.datetime "created_on",                     :null => false
    t.datetime "updated_on",                     :null => false
  end

  create_table "product_categories", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on", :null => false
    t.datetime "updated_on", :null => false
  end

  create_table "product_types", :force => true do |t|
    t.string   "name",                :null => false
    t.integer  "product_category_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on",          :null => false
    t.datetime "updated_on",          :null => false
  end

  create_table "products", :force => true do |t|
    t.integer  "product_type_id",  :null => false
    t.string   "model",            :null => false
    t.string   "vendor",           :null => false
    t.integer  "inventory_number"
    t.string   "serial_number"
    t.string   "description"
    t.integer  "ip_adress"
    t.integer  "mac_adress"
    t.integer  "speed"
    t.integer  "wired"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "products_features", :force => true do |t|
    t.integer  "product_id",  :null => false
    t.integer  "feature_id",  :null => false
    t.text     "description", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "providers", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on", :null => false
    t.datetime "updated_on", :null => false
  end

  create_table "room_types", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on", :null => false
    t.datetime "updated_on", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.integer  "building_id",  :null => false
    t.integer  "room_type_id", :null => false
    t.string   "number"
    t.string   "floor"
    t.string   "name"
    t.integer  "moduser_id"
    t.datetime "created_on",   :null => false
    t.datetime "updated_on",   :null => false
  end

  create_table "user_groups", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "group_id",   :null => false
    t.integer  "moduser_id"
    t.datetime "created_on", :null => false
    t.datetime "updated_on", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",      :null => false
    t.string   "password",   :null => false
    t.boolean  "status",     :null => false
    t.datetime "created_on", :null => false
    t.datetime "updated_on", :null => false
  end

end
