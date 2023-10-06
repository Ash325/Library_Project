# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_06_090626) do
  create_table "books", force: :cascade do |t|
    t.string "name"
    t.string "author"
    t.string "language"
    t.date "publication_date"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "library_id" , null: false
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["library_id"], name: "index_books_on_library_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "no_of_book"
    t.integer "library_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_id"], name: "index_categories_on_library_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "contact_no"
    t.string "description"
    t.integer "rating"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_libraries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.integer "mobile_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.integer "role"
  end

  add_foreign_key "books", "categories"
  add_foreign_key "books", "libraries"
  add_foreign_key "categories", "libraries"
  add_foreign_key "libraries", "users"
end
