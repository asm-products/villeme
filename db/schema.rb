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

ActiveRecord::Schema.define(version: 20141123234849) do

  create_table "agenda_events", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agendas", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "average_caches", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges_sashes", force: true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "categories_events", id: false, force: true do |t|
    t.integer  "category_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_places", id: false, force: true do |t|
    t.integer  "category_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "label"
    t.integer  "goal"
    t.string   "country_name"
    t.string   "country_code"
    t.string   "state_name"
    t.string   "state_code"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "price_id"
    t.string   "address"
    t.date     "date_start"
    t.time     "hour_start_first"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.date     "date_finish"
    t.time     "hour_finish_first"
    t.string   "number"
    t.decimal  "cost",               precision: 8, scale: 2
    t.time     "hour_start_second"
    t.time     "hour_start_third"
    t.time     "hour_start_fourth"
    t.time     "hour_start_fifth"
    t.time     "hour_start_sixth"
    t.time     "hour_finish_second"
    t.time     "hour_finish_third"
    t.time     "hour_finish_fourth"
    t.time     "hour_finish_fifth"
    t.time     "hour_finish_sixth"
    t.text     "cost_details"
    t.integer  "moderate"
    t.string   "slug"
    t.integer  "persona_id"
    t.string   "link"
    t.string   "email"
    t.string   "phone"
    t.integer  "subcategory_id"
    t.string   "full_address"
    t.string   "country_name"
    t.string   "country_code"
    t.string   "postal_code"
    t.string   "state_name"
    t.string   "state_code"
    t.string   "formatted_address"
    t.string   "city_name"
    t.string   "neighborhood_name"
    t.string   "street_number"
    t.string   "route"
  end

  add_index "events", ["persona_id"], name: "index_events_on_persona_id"
  add_index "events", ["place_id"], name: "index_events_on_place_id"
  add_index "events", ["price_id"], name: "index_events_on_price_id"
  add_index "events", ["slug"], name: "index_events_on_slug"
  add_index "events", ["subcategory_id"], name: "index_events_on_subcategory_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "events_weeks", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "week_id"
  end

  add_index "events_weeks", ["event_id", "week_id"], name: "index_events_weeks_on_event_id_and_week_id", unique: true
  add_index "events_weeks", ["week_id"], name: "index_events_weeks_on_week_id"

  create_table "feedbacks", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.boolean  "confirmed",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "accepted_at"
  end

  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id"

  create_table "invites", force: true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "name"
    t.integer  "city"
    t.integer  "persona"
    t.string   "persona_sugest"
    t.string   "city_sugest"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale",         default: "en"
  end

  add_index "invites", ["user_id"], name: "index_invites_on_user_id"

  create_table "levels", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.integer  "nivel"
    t.string   "url"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "merit_actions", force: true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "neighborhoods", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "slug"
    t.string   "state_name"
    t.string   "state_code"
    t.string   "country_name"
    t.string   "country_code"
    t.string   "city_name"
  end

  add_index "neighborhoods", ["slug"], name: "index_neighborhoods_on_slug", unique: true

  create_table "notifies", force: true do |t|
    t.integer  "user_id"
    t.datetime "bell_view"
    t.datetime "newsfeed_view"
    t.datetime "persona_view"
    t.datetime "neighborhood_view"
    t.datetime "agenda_view"
    t.datetime "category_view"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifies", ["user_id"], name: "index_notifies_on_user_id"

  create_table "overall_averages", force: true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "neighborhood_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "full_address"
    t.string   "country_name"
    t.string   "country_code"
    t.string   "postal_code"
    t.string   "state_name"
    t.string   "state_code"
    t.string   "formatted_address"
    t.string   "neighborhood_name"
    t.string   "city_name"
    t.string   "street_number"
    t.string   "route"
  end

  add_index "places", ["neighborhood_id"], name: "index_places_on_neighborhood_id"

  create_table "prices", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id"

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "sashes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "states", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "country_name"
    t.string   "country_code"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "subcategories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: true do |t|
    t.text     "description"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "tips", ["event_id"], name: "index_tips_on_event_id"
  add_index "tips", ["user_id"], name: "index_tips_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "username"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "provider"
    t.string   "uid"
    t.integer  "sash_id"
    t.integer  "level_id",               default: 1
    t.boolean  "admin",                  default: false
    t.integer  "persona_id"
    t.boolean  "account_complete",       default: false
    t.boolean  "invited",                default: false
    t.string   "token"
    t.string   "facebook_avatar"
    t.string   "slug"
    t.string   "token_expires_at"
    t.string   "locale"
    t.string   "postal_code"
    t.string   "neighborhood_name"
    t.string   "city_name"
    t.string   "state_name"
    t.string   "state_code"
    t.string   "country_name"
    t.string   "country_code"
    t.string   "street_number"
    t.string   "full_address"
    t.string   "route"
    t.string   "address"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["persona_id"], name: "index_users_on_persona_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

  create_table "weeks", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "binary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organizer_id"
  end

end
