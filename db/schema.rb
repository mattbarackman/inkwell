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

ActiveRecord::Schema.define(:version => 20130709223847) do

  create_table "admins", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  create_table "cards", :force => true do |t|
    t.integer  "price"
    t.string   "company_name"
    t.string   "company_city"
    t.string   "company_url"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "title"
    t.text     "description"
    t.integer  "inventory"
    t.integer  "listing_id"
    t.string   "status",       :default => "inactive"
  end

  create_table "cards_tags", :force => true do |t|
    t.integer "card_id"
    t.integer "tag_id"
  end

  add_index "cards_tags", ["card_id"], :name => "index_cards_tags_on_card_id"
  add_index "cards_tags", ["tag_id"], :name => "index_cards_tags_on_tag_id"

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "image_url"
  end

  add_index "friends", ["user_id"], :name => "index_friends_on_user_id"

  create_table "occasions", :force => true do |t|
    t.integer  "friend_id"
    t.date     "date"
    t.string   "name"
    t.string   "event_type_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "occasions", ["friend_id"], :name => "index_occasions_on_friend_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.integer  "occasion_id",                        :null => false
    t.integer  "card_id"
    t.integer  "lead_time",   :default => 604800
    t.string   "status",      :default => "no_card"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "photos", :force => true do |t|
    t.integer  "card_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
