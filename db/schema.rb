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

ActiveRecord::Schema.define(version: 20170924060815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.integer  "admin_id"
    t.integer  "user_ids",    default: [],              array: true
    t.string   "background"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["admin_id"], name: "index_boards_on_admin_id", using: :btree
  end

  create_table "checkpoints", force: :cascade do |t|
    t.integer "ticket_id"
    t.string  "title"
    t.decimal "rate_points"
    t.index ["ticket_id"], name: "index_checkpoints_on_ticket_id", using: :btree
  end

  create_table "columns", force: :cascade do |t|
    t.integer "board_id"
    t.string  "status_name"
    t.string  "title"
    t.text    "description"
    t.integer "order_number"
    t.index ["board_id"], name: "index_columns_on_board_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_comments_on_ticket_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "column_id"
    t.string   "title"
    t.text     "description"
    t.integer  "order_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["column_id"], name: "index_tickets_on_column_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "checkpoints", "tickets"
  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users"
end
