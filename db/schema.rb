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

ActiveRecord::Schema.define(version: 20170522010841) do

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.date "released_on", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author"], name: "index_books_on_author"
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["title"], name: "index_books_on_title"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer "book_id", null: false
    t.string "borrower", null: false
    t.date "borrowed_on", null: false
    t.date "should_return_on", null: false
    t.date "returned_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_requests_on_book_id"
    t.index ["borrowed_on"], name: "index_requests_on_borrowed_on"
    t.index ["borrower"], name: "index_requests_on_borrower"
    t.index ["returned_on"], name: "index_requests_on_returned_on"
    t.index ["should_return_on"], name: "index_requests_on_should_return_on"
  end

end
