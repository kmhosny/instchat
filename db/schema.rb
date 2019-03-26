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

ActiveRecord::Schema.define(version: 2019_03_26_091604) do

  create_table "apps", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_apps_on_id"
  end

  create_table "chats", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "app_id"
    t.index ["app_id"], name: "index_chats_on_app_id"
    t.index ["id", "app_id"], name: "index_chats_on_id_and_app_id", unique: true
  end

  add_foreign_key "chats", "apps"
end
