# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_25_064646) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "badges", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.text "icon_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookmarked_challenges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "challenge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_bookmarked_challenges_on_challenge_id"
    t.index ["user_id", "challenge_id"], name: "index_bookmarked_challenges_on_user_id_and_challenge_id", unique: true
    t.index ["user_id"], name: "index_bookmarked_challenges_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "challenge_comments", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.bigint "user_id", null: false
    t.text "body", null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "edited_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_challenge_comments_on_challenge_id"
    t.index ["user_id"], name: "index_challenge_comments_on_user_id"
  end

  create_table "challenge_invites", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.bigint "user_id"
    t.datetime "accepted_at"
    t.boolean "is_accepted", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "inviter_id"
    t.bigint "invitee_user_id"
    t.index ["challenge_id"], name: "index_challenge_invites_on_challenge_id"
    t.index ["user_id"], name: "index_challenge_invites_on_user_id"
  end

  create_table "challenge_participations", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.bigint "user_id", null: false
    t.string "status", null: false
    t.datetime "joined_at", null: false
    t.bigint "total_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_challenge_participations_on_challenge_id"
    t.index ["user_id"], name: "index_challenge_participations_on_user_id"
  end

  create_table "challenge_requests", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.bigint "requester_id", null: false
    t.string "status", null: false
    t.text "message"
    t.bigint "decided_by_id"
    t.datetime "decided_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id", "requester_id"], name: "index_challenge_requests_on_challenge_id_and_requester_id", unique: true
    t.index ["decided_by_id"], name: "index_challenge_requests_on_decided_by_id"
    t.index ["requester_id"], name: "index_challenge_requests_on_requester_id"
    t.index ["status"], name: "index_challenge_requests_on_status"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "visibility", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_challenges_on_category_id"
    t.index ["creator_id"], name: "index_challenges_on_creator_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.string "notification_type", null: false
    t.string "related_type", null: false
    t.bigint "related_id", null: false
    t.boolean "is_read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_type"], name: "index_notifications_on_notification_type"
    t.index ["related_type", "related_id"], name: "index_notifications_on_related"
    t.index ["related_type", "related_id"], name: "index_notifications_on_related_type_and_related_id"
    t.index ["user_id", "is_read"], name: "index_notifications_on_user_id_and_is_read"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "progress_logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "challenge_id", null: false
    t.text "description"
    t.float "progress_value", null: false
    t.string "unit", null: false
    t.datetime "logged_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_progress_logs_on_challenge_id"
    t.index ["user_id"], name: "index_progress_logs_on_user_id"
  end

  create_table "user_badges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "badge_id", null: false
    t.bigint "challenge_id", null: false
    t.datetime "awarded_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id"
    t.index ["challenge_id"], name: "index_user_badges_on_challenge_id"
    t.index ["user_id", "badge_id", "challenge_id"], name: "index_user_badges_on_user_id_and_badge_id_and_challenge_id", unique: true
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "role"
    t.string "email"
    t.string "password"
    t.text "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookmarked_challenges", "challenges"
  add_foreign_key "bookmarked_challenges", "users"
  add_foreign_key "challenge_comments", "challenges"
  add_foreign_key "challenge_comments", "users"
  add_foreign_key "challenge_invites", "challenges"
  add_foreign_key "challenge_invites", "users"
  add_foreign_key "challenge_participations", "challenges"
  add_foreign_key "challenge_participations", "users"
  add_foreign_key "challenge_requests", "challenges"
  add_foreign_key "challenge_requests", "users", column: "decided_by_id"
  add_foreign_key "challenge_requests", "users", column: "requester_id"
  add_foreign_key "challenges", "categories"
  add_foreign_key "challenges", "users", column: "creator_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "progress_logs", "challenges"
  add_foreign_key "progress_logs", "users"
  add_foreign_key "user_badges", "badges"
  add_foreign_key "user_badges", "challenges"
  add_foreign_key "user_badges", "users"
end
