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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120908163414) do

  create_table "companies", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "money",   :default => 100000
  end

  add_index "companies", ["user_id"], :name => "index_companies_on_user_id", :unique => true

  create_table "config_variables", :id => false, :force => true do |t|
    t.string "key"
    t.string "value"
  end

  add_index "config_variables", ["key"], :name => "index_config_variables_on_key", :unique => true

  create_table "programs", :force => true do |t|
    t.integer "company_id"
    t.string  "name"
    t.boolean "available",  :default => false
    t.string  "type"
    t.integer "popularity", :default => 1
    t.string  "genre"
  end

  add_index "programs", ["company_id"], :name => "index_programs_on_company_id"

  create_table "slots", :force => true do |t|
    t.integer  "company_id"
    t.integer  "program_id"
    t.integer  "day"
    t.integer  "time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "audience"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updates_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
