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

ActiveRecord::Schema.define(version: 20171017234336) do

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "abstract"
    t.string "author"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_uid"
    t.integer "user_id"
    t.string "file_name"
    t.integer "journal_id"
    t.integer "position", default: 0
    t.integer "referee_1_id"
    t.integer "referee_2_id"
    t.integer "referee_3_id"
  end

  create_table "journals", force: :cascade do |t|
    t.string "identifier"
    t.string "editor"
    t.string "publisher"
    t.string "indexing"
    t.string "copyright"
    t.string "subject"
    t.string "others"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_name", default: ""
    t.integer "status", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0
    t.integer "gender", default: 0
    t.string "institution"
    t.string "phone"
    t.string "address"
    t.string "country"
    t.string "bio"
    t.string "web_site"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_articles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "article_id"
    t.integer "status"
    t.text "correction_note"
    t.integer "referee_1_id"
    t.integer "referee_2_id"
    t.integer "referee_3_id"
  end

end
