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

ActiveRecord::Schema.define(version: 20160222175704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "access_tokens", force: true do |t|
    t.uuid     "user_id",      null: false
    t.string   "access_token", null: false
    t.datetime "expires_at",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["access_token"], name: "index_access_tokens_on_access_token", unique: true, using: :btree
  add_index "access_tokens", ["user_id"], name: "index_access_tokens_on_user_id", using: :btree

  create_table "pairings", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.uuid     "pull_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pull_request_reviews", force: true do |t|
    t.uuid     "user_id"
    t.uuid     "pull_request_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pull_requests", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "base_repo_full_name"
    t.integer  "number"
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_comments"
    t.integer  "number_of_commits"
    t.integer  "number_of_additions"
    t.integer  "number_of_deletions"
    t.integer  "number_of_changed_files"
    t.datetime "merged_at"
    t.text     "body"
  end

  create_table "scores", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.integer  "points",     default: 0
    t.string   "time_span",  default: "all_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "avatar_url"
    t.string   "api_token"
    t.string   "github_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weekly_winnings", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "winner_id"
    t.date     "start_date"
    t.integer  "points",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
