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

ActiveRecord::Schema.define(version: 20150118032924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_details", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_features", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "name"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "item_features", ["item_id"], name: "index_item_features_on_item_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "grade"
    t.integer  "department"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "year"
    t.string   "english_name"
    t.string   "term"
    t.integer  "credit_num"
    t.string   "credit_requirement"
    t.string   "assign"
  end

  create_table "rating_details", force: :cascade do |t|
    t.integer  "rating_id"
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "item_detail_id"
    t.boolean  "negative_cause"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "rating_details", ["item_detail_id"], name: "index_rating_details_on_item_detail_id", using: :btree
  add_index "rating_details", ["item_id"], name: "index_rating_details_on_item_id", using: :btree
  add_index "rating_details", ["rating_id"], name: "index_rating_details_on_rating_id", using: :btree
  add_index "rating_details", ["user_id"], name: "index_rating_details_on_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.float    "score"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "prediction", default: false
    t.boolean  "taken",      default: false
  end

  add_index "ratings", ["item_id"], name: "index_ratings_on_item_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.integer  "grade"
    t.integer  "department"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_similarities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.float    "value"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "rated_items_num", default: 0
  end

  add_index "users_similarities", ["user_id"], name: "index_users_similarities_on_user_id", using: :btree

  add_foreign_key "item_features", "items"
  add_foreign_key "rating_details", "item_details"
  add_foreign_key "rating_details", "items"
  add_foreign_key "rating_details", "ratings"
  add_foreign_key "rating_details", "users"
  add_foreign_key "ratings", "items"
  add_foreign_key "ratings", "users"
  add_foreign_key "users_similarities", "users"
end
