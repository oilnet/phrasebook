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

ActiveRecord::Schema.define(version: 20150920160805) do

  create_table "phrases", force: :cascade do |t|
    t.text     "text"
    t.string   "tags"
    t.string   "rec_filename"
    t.string   "rec_filetype"
    t.binary   "rec_contents"
    t.integer  "usefulness"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string   "text"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", force: :cascade do |t|
    t.integer  "phrase_id"
    t.text     "original"
    t.text     "transliteration"
    t.binary   "recording_data"
    t.string   "language"
    t.string   "source_country"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "translations", ["phrase_id"], name: "index_translations_on_phrase_id"

end
