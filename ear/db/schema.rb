# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101127000000) do

  create_table "domains", :force => true do |t|
    t.integer  "host_id"
    t.string   "name"
    t.text     "description"
    t.string   "referral_whois"
    t.string   "referral_url"
    t.string   "status"
    t.string   "registered"
    t.string   "available"
    t.string   "created_on"
    t.string   "updated_on"
    t.string   "expires_on"
    t.string   "registrar"
    t.string   "registrant_contact"
    t.string   "admin_contact"
    t.string   "technical_contact"
    t.string   "nameservers"
    t.text     "disclaimer"
    t.text     "fulltext"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", :force => true do |t|
    t.string   "ip"
    t.string   "name"
    t.text     "description"
    t.integer  "traffic_count", :default => 1
    t.integer  "location_id"
    t.integer  "network_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "networks", :force => true do |t|
    t.text     "description"
    t.string   "range"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "object_mappings", :force => true do |t|
    t.integer "child_id"
    t.string  "child_type"
    t.integer "parent_id"
    t.string  "parent_type"
    t.integer "task_run_id"
    t.string  "description"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "type"
    t.string   "address"
    t.integer  "host_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_runs", :force => true do |t|
    t.string   "task_name"
    t.integer  "task_object_id"
    t.string   "task_object_type"
    t.string   "task_options_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "type"
    t.string   "target_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "alias"
    t.string   "mask"
    t.string   "email"
    t.integer  "organization_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
