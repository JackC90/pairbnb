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

ActiveRecord::Schema.define(version: 20161127153937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.boolean  "pool"
    t.boolean  "wifi"
    t.boolean  "gym"
    t.boolean  "kitchen"
    t.boolean  "golf_course"
    t.boolean  "tennis_court"
    t.integer  "listing_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["listing_id"], name: "index_amenities_on_listing_id", using: :btree
  end

  create_table "listings", force: :cascade do |t|
    t.text     "address"
    t.decimal  "price"
    t.string   "location"
    t.text     "description"
    t.boolean  "availability"
    t.integer  "max_occupants"
    t.integer  "no_of_bedrooms"
    t.integer  "no_of_bathrooms"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "title"
    t.string   "images",          default: [],              array: true
    t.date     "date_begin"
    t.date     "date_end"
    t.string   "place_type"
    t.string   "property_type"
    t.index ["user_id"], name: "index_listings_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.string   "country"
    t.text     "description"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "phone"
    t.string   "email"
    t.string   "language"
    t.string   "currency"
    t.string   "school"
    t.string   "work"
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "reservations", force: :cascade do |t|
    t.date     "date_in"
    t.date     "date_out"
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "no_of_guests", default: 1
    t.decimal  "total_price",  default: "0.0"
    t.index ["listing_id"], name: "index_reservations_on_listing_id", using: :btree
    t.index ["user_id"], name: "index_reservations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "email",                                      null: false
    t.string   "encrypted_password", limit: 128,             null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,             null: false
    t.integer  "role",                           default: 0
    t.string   "avatar"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "amenities", "listings"
  add_foreign_key "listings", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "reservations", "listings"
  add_foreign_key "reservations", "users"
end
