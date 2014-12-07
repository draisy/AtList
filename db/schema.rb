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

ActiveRecord::Schema.define(version: 20141203170447) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "category_score", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "favorite_image"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "influences", force: true do |t|
    t.integer  "score",       default: 0
    t.integer  "favorite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "list_score",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pokes", force: true do |t|
    t.integer  "influence_id"
    t.integer  "receiver_id"
    t.integer  "giver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relists", force: true do |t|
    t.integer  "influence_id"
    t.integer  "receiver_id"
    t.integer  "giver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_categories", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_image"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_score", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

end
