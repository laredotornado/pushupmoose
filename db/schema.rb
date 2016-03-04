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

ActiveRecord::Schema.define(version: 20160229222006) do

  create_table "exercises", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "user_exercises", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "exercise_id", limit: 4, null: false
    t.date     "day",                   null: false
    t.integer  "total",       limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "user_exercises", ["exercise_id"], name: "fk_rails_47d60a969f", using: :btree
  add_index "user_exercises", ["user_id", "day", "exercise_id"], name: "index_user_exercises_on_user_id_and_day_and_exercise_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "firstName",              limit: 255
    t.string   "lastName",               limit: 255
    t.string   "email",                  limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.string   "image_url",              limit: 255
    t.string   "url",                    limit: 255
    t.string   "location",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "user_exercises", "exercises"
  add_foreign_key "user_exercises", "users"
end
