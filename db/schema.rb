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

ActiveRecord::Schema[7.1].define(version: 2024_07_26_204750) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "status", ["draft", "published"]

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", null: false
    t.string "firstname"
    t.string "surname"
    t.boolean "admin", default: false
    t.boolean "mod", default: false
    t.string "bio"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_type", default: 0, null: false
    t.string "organization_name"
    t.integer "organization_type", default: 0, null: false
    t.integer "status", default: 0
    t.integer "current_account"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "country"
    t.string "state"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_addresses_on_account_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.integer "saves_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_articles_on_account_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "bookmarkable_type", null: false
    t.bigint "bookmarkable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "bookmarkable_type", "bookmarkable_id"], name: "idx_on_account_id_bookmarkable_type_bookmarkable_id_5b0c838494", unique: true
    t.index ["account_id"], name: "index_bookmarks_on_account_id"
    t.index ["bookmarkable_type", "bookmarkable_id"], name: "index_bookmarks_on_bookmarkable"
    t.index ["bookmarkable_type", "bookmarkable_id"], name: "index_bookmarks_on_bookmarkable_type_and_bookmarkable_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.text "body"
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_comments_on_account_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
  end

  create_table "discussions", force: :cascade do |t|
    t.string "title"
    t.bigint "forum_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "bookmarks_count", default: 0, null: false
    t.index ["account_id"], name: "index_discussions_on_account_id"
    t.index ["forum_id"], name: "index_discussions_on_forum_id"
  end

  create_table "event_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_event_categories_on_account_id"
  end

  create_table "event_co_hosts", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "account_id", null: false
    t.integer "role", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "decline_count", default: 0
    t.index ["account_id"], name: "index_event_co_hosts_on_account_id"
    t.index ["event_id", "account_id"], name: "index_event_co_hosts_on_event_id_and_account_id", unique: true
    t.index ["event_id"], name: "index_event_co_hosts_on_event_id"
  end

  create_table "event_speakers", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.bigint "account_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_event_speakers_on_account_id"
    t.index ["event_id"], name: "index_event_speakers_on_event_id"
  end

  create_table "event_talks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "account_id", null: false
    t.bigint "event_id", null: false
    t.bigint "event_speaker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_event_talks_on_account_id"
    t.index ["event_id"], name: "index_event_talks_on_event_id"
    t.index ["event_speaker_id"], name: "index_event_talks_on_event_speaker_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.time "start_time"
    t.date "end_date"
    t.time "end_time"
    t.text "details"
    t.string "street_address"
    t.string "streaming_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id", null: false
    t.bigint "event_category_id", null: false
    t.integer "event_type"
    t.integer "cost_type"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "time_zone"
    t.enum "status", default: "draft", null: false, enum_type: "status"
    t.index ["account_id"], name: "index_events_on_account_id"
    t.index ["event_category_id"], name: "index_events_on_event_category_id"
  end

  create_table "forums", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_forums_on_account_id"
  end

  create_table "joinables", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_joinables_on_account_id"
    t.index ["room_id"], name: "index_joinables_on_room_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "likeable_type", null: false
    t.bigint "likeable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "likeable_id", "likeable_type"], name: "index_likes_on_account_id_and_likeable_id_and_likeable_type", unique: true
    t.index ["account_id"], name: "index_likes_on_account_id"
    t.index ["likeable_id", "likeable_type"], name: "index_likes_on_likeable_id_and_likeable_type"
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "room_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_messages_on_account_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_participants_on_account_id"
    t.index ["room_id"], name: "index_participants_on_room_id"
  end

  create_table "prayer_requests", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "account_id", null: false
    t.integer "saves_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_prayer_requests_on_account_id"
  end

  create_table "resource_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "youtube_id"
    t.bigint "resource_category_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_resources_on_account_id"
    t.index ["resource_category_id"], name: "index_resources_on_resource_category_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.boolean "is_private", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_message_at"
  end

  create_table "rsvps", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "rsvpable_type", null: false
    t.bigint "rsvpable_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_rsvps_on_account_id"
    t.index ["rsvpable_type", "rsvpable_id"], name: "index_rsvps_on_rsvpable"
  end

  create_table "speaker_profiles", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.bigint "event_speaker_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_speaker_profiles_on_account_id"
    t.index ["event_speaker_id"], name: "index_speaker_profiles_on_event_speaker_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "accounts"
  add_foreign_key "articles", "accounts"
  add_foreign_key "bookmarks", "accounts"
  add_foreign_key "comments", "accounts"
  add_foreign_key "discussions", "accounts"
  add_foreign_key "discussions", "forums"
  add_foreign_key "event_categories", "accounts"
  add_foreign_key "event_co_hosts", "accounts"
  add_foreign_key "event_co_hosts", "events"
  add_foreign_key "event_speakers", "accounts"
  add_foreign_key "event_speakers", "events"
  add_foreign_key "event_talks", "accounts"
  add_foreign_key "event_talks", "event_speakers"
  add_foreign_key "event_talks", "events"
  add_foreign_key "events", "accounts"
  add_foreign_key "events", "event_categories"
  add_foreign_key "forums", "accounts"
  add_foreign_key "joinables", "accounts"
  add_foreign_key "joinables", "rooms"
  add_foreign_key "likes", "accounts"
  add_foreign_key "messages", "accounts"
  add_foreign_key "messages", "rooms"
  add_foreign_key "participants", "accounts"
  add_foreign_key "participants", "rooms"
  add_foreign_key "prayer_requests", "accounts"
  add_foreign_key "resources", "accounts"
  add_foreign_key "resources", "resource_categories"
  add_foreign_key "rsvps", "accounts"
  add_foreign_key "speaker_profiles", "accounts"
  add_foreign_key "speaker_profiles", "event_speakers"
end
