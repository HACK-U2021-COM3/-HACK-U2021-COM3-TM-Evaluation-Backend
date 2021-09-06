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

ActiveRecord::Schema.define(version: 2021_09_06_144601) do

  create_table "past_plan_details", force: :cascade do |t|
    t.integer "past_plan_id", null: false
    t.integer "order_number"
    t.float "longitude"
    t.float "latitude"
    t.integer "stay_time"
    t.index ["past_plan_id"], name: "index_past_plan_details_on_past_plan_id"
  end

  create_table "past_plans", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.integer "sum_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_past_plans_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
  end

  add_foreign_key "past_plan_details", "past_plans"
  add_foreign_key "past_plans", "users"
end
