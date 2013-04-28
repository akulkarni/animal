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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130428212724) do

  create_table "daily_questions", :force => true do |t|
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "daily_records", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "question_message"
    t.text     "message"
  end

  create_table "foursquare_checkins", :force => true do |t|
    t.string   "foursquare_user_id"
    t.string   "venue_id"
    t.string   "venue_name"
    t.string   "category"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "foursquare_users", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "access_token"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "phone_number"
    t.string   "foursquare_user_id"
  end

  create_table "record_users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "name"
    t.string   "phone_number"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "workout_logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "feedback"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "workouts", :force => true do |t|
    t.text     "raw"
    t.text     "html"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "date"
  end

end
