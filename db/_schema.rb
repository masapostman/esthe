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

ActiveRecord::Schema.define(version: 20150119022108) do

  create_table "administrators", force: true do |t|
    t.string   "email",                           null: false
    t.string   "email_for_index",                 null: false
    t.string   "password_digest"
    t.boolean  "suspended",       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administrators", ["email_for_index"], name: "index_administrators_on_email_for_index", unique: true, using: :btree

  create_table "customers", force: true do |t|
    t.string   "reception_number"
    t.integer  "company_code"
    t.string   "company_name"
    t.string   "top_family_name",                        null: false
    t.string   "top_given_name",                         null: false
    t.string   "top_family_name_kana",                   null: false
    t.string   "top_given_name_kana",                    null: false
    t.string   "staff_family_name",                      null: false
    t.string   "staff_given_name",                       null: false
    t.string   "staff_family_name_kana",                 null: false
    t.string   "staff_given_name_kana",                  null: false
    t.string   "zip_code",                               null: false
    t.string   "prefecture",                             null: false
    t.string   "city",                                   null: false
    t.string   "address1",                               null: false
    t.string   "address2"
    t.string   "telephone_number"
    t.string   "mobilephone_number"
    t.string   "fax_number"
    t.string   "email",                                  null: false
    t.string   "email_for_index",                        null: false
    t.string   "password_digest"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "suspended",              default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["company_code"], name: "index_customers_on_company_code", unique: true, using: :btree
  add_index "customers", ["email_for_index"], name: "index_customers_on_email_for_index", unique: true, using: :btree

  create_table "loanorders", force: true do |t|
    t.string   "company_code",      null: false
    t.string   "company_name",      null: false
    t.date     "receipt_date",      null: false
    t.string   "receipt_number",    null: false
    t.string   "family_name",       null: false
    t.string   "given_name",        null: false
    t.string   "loan_company_code", null: false
    t.string   "loan_company_name", null: false
    t.string   "application_money", null: false
    t.string   "status",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff_events", force: true do |t|
    t.integer  "staff_member_id", null: false
    t.string   "type",            null: false
    t.datetime "created_at",      null: false
  end

  add_index "staff_events", ["created_at"], name: "index_staff_events_on_created_at", using: :btree
  add_index "staff_events", ["staff_member_id", "created_at"], name: "index_staff_events_on_staff_member_id_and_created_at", using: :btree

  create_table "staff_members", force: true do |t|
    t.string   "email",                            null: false
    t.string   "email_for_index",                  null: false
    t.string   "family_name",                      null: false
    t.string   "given_name",                       null: false
    t.string   "family_name_kana",                 null: false
    t.string   "given_name_kana",                  null: false
    t.string   "password_digest"
    t.date     "start_date",                       null: false
    t.date     "end_date"
    t.boolean  "suspended",        default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staff_members", ["email_for_index"], name: "index_staff_members_on_email_for_index", unique: true, using: :btree
  add_index "staff_members", ["family_name_kana", "given_name_kana"], name: "index_staff_members_on_family_name_kana_and_given_name_kana", using: :btree

  add_foreign_key "staff_events", "staff_members", name: "staff_events_staff_member_id_fk"

end
