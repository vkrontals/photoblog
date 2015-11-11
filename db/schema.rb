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

ActiveRecord::Schema.define(version: 20151111185036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.string   "url"
    t.datetime "uploaded_time"
    t.string   "alt_txt"
    t.string   "caption"
    t.integer  "post_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "images", ["post_id"], name: "index_images_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "author_id"
    t.text     "content"
    t.datetime "publish_date"
    t.string   "title"
    t.text     "excerpt"
    t.string   "permalink"
    t.string   "status"
    t.integer  "comment_count"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["permalink"], name: "index_posts_on_permalink", using: :btree

  create_table "posts_terms", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts_terms", ["post_id", "term_id"], name: "index_posts_terms_on_post_id_and_term_id", using: :btree

  create_table "terms", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "term_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "terms", ["slug"], name: "index_terms_on_slug", using: :btree
  add_index "terms", ["term_group"], name: "index_terms_on_term_group", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.string   "email"
    t.string   "url"
    t.string   "display_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
  end

end
