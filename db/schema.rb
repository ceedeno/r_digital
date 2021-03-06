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

ActiveRecord::Schema.define(version: 20171214195422) do

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
    t.string "key_words"
    t.integer "tmdcm_1_id"
    t.integer "tmdcm_2_id"
    t.boolean "tmdcm_1_review", default: false
    t.boolean "tmdcm_2_review", default: false
    t.date "referee_assigned_date"
    t.boolean "checked_as_corrected", default: false
    t.string "language", default: ""
    t.integer "kind"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "issn"
    t.string "electronic_issn"
    t.string "legal_deposit"
    t.date "creation_date"
    t.string "indexing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "cover_uid"
    t.date "publication_date"
    t.integer "volume_id"
    t.integer "max_articles"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "gender"
    t.string "institution"
    t.string "phone"
    t.string "address"
    t.string "country"
    t.string "bio"
    t.string "web_site"
    t.string "speciality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "selected_referees", force: :cascade do |t|
    t.integer "article_id"
    t.integer "referee_1_id"
    t.integer "referee_2_id"
    t.integer "referee_3_id"
    t.date "referee_assigned_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "role", default: 0
    t.string "first_name"
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
    t.boolean "checked_by_director", default: false
  end

  create_table "volumes", force: :cascade do |t|
    t.integer "number"
    t.integer "pages"
    t.date "creation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
