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

ActiveRecord::Schema.define(:version => 20130415140857) do

  create_table "committers", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "committers_repos", :force => true do |t|
    t.integer  "repo_id"
    t.integer  "committer_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "repos", :force => true do |t|
    t.string   "name"
    t.datetime "last_track_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "user"
  end

  create_table "snap_shots", :force => true do |t|
    t.integer  "commit_count"
    t.integer  "files_touched"
    t.integer  "additions"
    t.integer  "deletions"
    t.integer  "loc_touched"
    t.string   "tags"
    t.integer  "max_commit_size"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "repo_id"
    t.integer  "committer_id"
  end

  create_table "trackings", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
