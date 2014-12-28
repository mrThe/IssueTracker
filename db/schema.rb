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

ActiveRecord::Schema.define(version: 20141228184920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.integer  "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_histories", force: true do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.integer  "status_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "ticket_histories", ["owner_id"], name: "index_ticket_histories_on_owner_id", using: :btree
  add_index "ticket_histories", ["status_id"], name: "index_ticket_histories_on_status_id", using: :btree
  add_index "ticket_histories", ["ticket_id"], name: "index_ticket_histories_on_ticket_id", using: :btree
  add_index "ticket_histories", ["user_id"], name: "index_ticket_histories_on_user_id", using: :btree

  create_table "tickets", force: true do |t|
    t.string   "sub_id",         null: false
    t.string   "customer_name",  null: false
    t.string   "customer_email", null: false
    t.string   "subject",        null: false
    t.text     "message",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.integer  "status_id"
  end

  add_index "tickets", ["owner_id"], name: "index_tickets_on_owner_id", using: :btree
  add_index "tickets", ["status_id"], name: "index_tickets_on_status_id", using: :btree
  add_index "tickets", ["sub_id"], name: "index_tickets_on_sub_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
