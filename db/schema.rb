# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_07_151433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.integer "upvotes"
    t.bigint "user_id", null: false
    t.bigint "megalith_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["megalith_id"], name: "index_comments_on_megalith_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "megalith_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["megalith_id"], name: "index_favourites_on_megalith_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "megalith_photos", force: :cascade do |t|
    t.integer "upvote_score"
    t.bigint "user_id", null: false
    t.bigint "megalith_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["megalith_id"], name: "index_megalith_photos_on_megalith_id"
    t.index ["user_id"], name: "index_megalith_photos_on_user_id"
  end

  create_table "megaliths", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "category"
    t.string "tagline"
    t.text "description"
    t.float "average_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "fake_photo_key"
  end

  create_table "other_locations", force: :cascade do |t|
    t.string "category"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.integer "upvote_score"
    t.bigint "trip_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trip_id"], name: "index_other_locations_on_trip_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "score"
    t.bigint "megalith_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["megalith_id"], name: "index_ratings_on_megalith_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "trip_megaliths", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.bigint "megalith_id", null: false
    t.boolean "main"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["megalith_id"], name: "index_trip_megaliths_on_megalith_id"
    t.index ["trip_id"], name: "index_trip_megaliths_on_trip_id"
  end

  create_table "trip_photos", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trip_id"], name: "index_trip_photos_on_trip_id"
  end

  create_table "trip_users", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trip_id"], name: "index_trip_users_on_trip_id"
    t.index ["user_id"], name: "index_trip_users_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.string "tagline"
    t.string "top_tip"
    t.text "description"
    t.date "date_visited"
    t.integer "upvote_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "published"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.integer "overall_rating", default: 0
    t.integer "photographer_score", default: 0
    t.integer "commenter_score", default: 0
    t.integer "tour_guide_score", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visiteds", force: :cascade do |t|
    t.bigint "megalith_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["megalith_id"], name: "index_visiteds_on_megalith_id"
    t.index ["user_id"], name: "index_visiteds_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "megaliths"
  add_foreign_key "comments", "users"
  add_foreign_key "favourites", "megaliths"
  add_foreign_key "favourites", "users"
  add_foreign_key "megalith_photos", "megaliths"
  add_foreign_key "megalith_photos", "users"
  add_foreign_key "other_locations", "trips"
  add_foreign_key "ratings", "megaliths"
  add_foreign_key "ratings", "users"
  add_foreign_key "trip_megaliths", "megaliths"
  add_foreign_key "trip_megaliths", "trips"
  add_foreign_key "trip_photos", "trips"
  add_foreign_key "trip_users", "trips"
  add_foreign_key "trip_users", "users"
  add_foreign_key "visiteds", "megaliths"
  add_foreign_key "visiteds", "users"
end
