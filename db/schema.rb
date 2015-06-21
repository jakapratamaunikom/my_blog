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

ActiveRecord::Schema.define(version: 20150621090713) do

  create_table "article_contents", force: :cascade do |t|
    t.text     "content"
    t.string   "title"
    t.string   "image"
    t.string   "lang"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.boolean  "published"
    t.integer  "article_id"
    t.text     "short_description"
  end

  create_table "article_contents_tags", force: :cascade do |t|
    t.integer "article_content_id"
    t.integer "tag_id"
  end

  create_table "articles", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "removed",    default: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "article_id"
    t.integer  "parent_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "file"
    t.integer  "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prides", force: :cascade do |t|
    t.integer  "objective_id"
    t.string   "objective_type"
    t.string   "lang"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "prides", ["objective_type", "objective_id"], name: "index_prides_on_objective_type_and_objective_id"

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "work_contents", force: :cascade do |t|
    t.string   "title"
    t.string   "lang"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "work_id"
    t.boolean  "published"
    t.string   "image"
  end

  create_table "works", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "removed",    default: false
  end

end
