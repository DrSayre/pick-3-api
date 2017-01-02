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

ActiveRecord::Schema.define(version: 20161229025435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drawing_times", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pick_threes", force: :cascade do |t|
    t.integer  "drawing_time_id"
    t.integer  "first_ball"
    t.integer  "second_ball"
    t.integer  "third_ball"
    t.date     "drawing_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "front_pair"
    t.integer  "back_pair"
    t.integer  "split_pair"
    t.integer  "numbers"
    t.index ["drawing_date", "drawing_time_id"], name: "index_pick_threes_on_drawing_date_and_drawing_time_id", unique: true, using: :btree
    t.index ["drawing_time_id"], name: "index_pick_threes_on_drawing_time_id", using: :btree
  end

end
