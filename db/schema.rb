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

ActiveRecord::Schema.define(version: 2021_11_17_093249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: :cascade do |t|
    t.text "comment", null: false
    t.string "owner_id", null: false
    t.bigint "feedbackable_id", null: false
    t.string "feedbackable_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feedbackable_type", "feedbackable_id"], name: "index_feedbacks_on_feedbackable_type_and_feedbackable_id"
    t.index ["owner_id"], name: "index_feedbacks_on_owner_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "content", null: false
    t.string "ip_address", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "stars", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_ratings_on_post_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_users_on_username"
  end

end
