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

ActiveRecord::Schema.define(version: 20150429172958) do

  create_table "badges", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "video_id",   limit: 4
    t.integer  "icon_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "badges", ["icon_id"], name: "index_badges_on_icon_id", using: :btree
  add_index "badges", ["user_id", "video_id", "icon_id"], name: "index_badges_on_user_id_and_video_id_and_icon_id", unique: true, using: :btree
  add_index "badges", ["user_id"], name: "index_badges_on_user_id", using: :btree
  add_index "badges", ["video_id"], name: "index_badges_on_video_id", using: :btree

  create_table "casts", force: :cascade do |t|
    t.integer  "video_id",          limit: 4
    t.integer  "assignee_id",       limit: 4
    t.integer  "assignor_id",       limit: 4
    t.string   "cast_type",         limit: 255
    t.boolean  "assignee_approved", limit: 1
    t.integer  "votes_count",       limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "casts", ["assignee_id"], name: "index_casts_on_assignee_id", using: :btree
  add_index "casts", ["assignor_id"], name: "index_casts_on_assignor_id", using: :btree
  add_index "casts", ["video_id", "assignee_id", "cast_type"], name: "index_casts_on_video_id_and_assignee_id_and_cast_type", unique: true, using: :btree

  create_table "channelgraphs", force: :cascade do |t|
    t.integer  "channel_id", limit: 4
    t.integer  "video_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "channelgraphs", ["channel_id", "video_id"], name: "index_channelgraphs_on_channel_id_and_video_id", unique: true, using: :btree
  add_index "channelgraphs", ["video_id"], name: "index_channelgraphs_on_video_id", using: :btree

  create_table "channels", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "url_token",           limit: 255
    t.string   "title",               limit: 255
    t.text     "description",         limit: 65535
    t.string   "image_url",           limit: 255
    t.integer  "subscriptions_count", limit: 4,     default: 0
    t.integer  "videos_count",        limit: 4,     default: 0
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "channels", ["title"], name: "channel_title_index", length: {"title"=>10}, using: :btree
  add_index "channels", ["user_id"], name: "index_channels_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "user_id",          limit: 4
    t.text     "content",          limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "icons", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.boolean  "is_visible",   limit: 1,   default: true
    t.string   "icon_type",    limit: 255, default: "badge"
    t.string   "icon_url",     limit: 255
    t.integer  "badges_count", limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id",   limit: 4
    t.integer  "user_id",             limit: 4
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message",             limit: 65535
    t.text     "referrer",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}, using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "karmas", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "event_type",  limit: 255
    t.integer  "event_value", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "karmas", ["user_id", "event_type"], name: "index_karmas_on_user_id_and_event_type", unique: true, using: :btree
  add_index "karmas", ["user_id"], name: "index_karmas_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "from_user_id", limit: 4
    t.integer  "to_user_id",   limit: 4
    t.datetime "read_at"
    t.text     "content",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "messages", ["from_user_id"], name: "index_messages_on_from_user_id", using: :btree
  add_index "messages", ["to_user_id"], name: "index_messages_on_to_user_id", using: :btree

  create_table "omniauth_authentications", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "omniauth_authentications", ["uid", "provider"], name: "index_omniauth_authentications_on_uid_and_provider", unique: true, using: :btree
  add_index "omniauth_authentications", ["user_id"], name: "index_omniauth_authentications_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "channel_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "subscriptions", ["channel_id", "user_id"], name: "index_subscriptions_on_channel_id_and_user_id", unique: true, using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "url_token",           limit: 255
    t.string   "email",               limit: 255
    t.string   "remember_token",      limit: 255
    t.string   "first_name",          limit: 255
    t.string   "last_name",           limit: 255
    t.string   "gender",              limit: 255
    t.string   "quote",               limit: 255,   default: "Give me a museum and I'll fill it."
    t.integer  "karma",               limit: 4,     default: 0
    t.integer  "comments_count",      limit: 4,     default: 0
    t.integer  "votes_count",         limit: 4,     default: 0
    t.integer  "subscriptions_count", limit: 4,     default: 0
    t.integer  "badges_count",        limit: 4,     default: 0
    t.integer  "videos_count",        limit: 4,     default: 0
    t.integer  "channels_count",      limit: 4,     default: 0
    t.integer  "impressions_count",   limit: 4,     default: 0
    t.integer  "unread_msg_count",    limit: 4,     default: 0
    t.integer  "cast_approval_count", limit: 4,     default: 0
    t.string   "profile_image_url",   limit: 255
    t.text     "bio",                 limit: 65535
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
  end

  add_index "users", ["first_name"], name: "search_user_name_first_index", length: {"first_name"=>10}, using: :btree
  add_index "users", ["last_name"], name: "search_user_name_last_index", length: {"last_name"=>10}, using: :btree
  add_index "users", ["url_token"], name: "user_index_url_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "url_token",           limit: 255
    t.string   "video_url",           limit: 255
    t.string   "video_thumbnail_url", limit: 255
    t.integer  "reputation",          limit: 4,     default: 0
    t.datetime "published_at"
    t.datetime "featured_at"
    t.datetime "claimed_at"
    t.boolean  "is_nsfw",             limit: 1,     default: false
    t.string   "title",               limit: 255
    t.text     "description",         limit: 65535
    t.integer  "channels_count",      limit: 4,     default: 0
    t.integer  "impressions_count",   limit: 4,     default: 0
    t.integer  "comments_count",      limit: 4,     default: 0
    t.integer  "badges_count",        limit: 4,     default: 0
    t.string   "video_urlid",         limit: 255
    t.string   "duration",            limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "videos", ["description"], name: "searching_description_index", length: {"description"=>10}, using: :btree
  add_index "videos", ["title"], name: "searching_title_index", length: {"title"=>10}, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 255
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "votes", ["user_id", "votable_id", "votable_type"], name: "index_votes_on_user_id_and_votable_id_and_votable_type", unique: true, using: :btree
  add_index "votes", ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", using: :btree

end
