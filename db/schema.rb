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

ActiveRecord::Schema.define(:version => 20121119142227) do

  create_table "chapters", :force => true do |t|
    t.string   "name"
    t.string   "dispid"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "chapters", ["parent_id"], :name => "index_chapters_on_parent_id"

  create_table "faches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "fach"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "faches", ["question_id"], :name => "index_faches_on_question_id"
  add_index "faches", ["user_id"], :name => "index_faches_on_user_id"

  create_table "hints", :force => true do |t|
    t.string   "author"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "chapter_id"
    t.string   "dispid"
    t.text     "question"
    t.text     "correctanswer"
    t.text     "wronganswer1"
    t.text     "wronganswer2"
    t.text     "wronganswer3"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "fullname"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "salt"
    t.string   "hashed_password"
    t.string   "exam_type"
    t.integer  "is_admin"
  end

end
