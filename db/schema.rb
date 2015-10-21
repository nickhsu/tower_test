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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151019070536) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "project_id", limit: 4
    t.string   "role",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "accesses", ["project_id"], name: "index_accesses_on_project_id", using: :btree
  add_index "accesses", ["user_id"], name: "index_accesses_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "todo_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["todo_id"], name: "index_comments_on_todo_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "actor_id",   limit: 4,     null: false
    t.integer  "project_id", limit: 4
    t.string   "event_type", limit: 255,   null: false
    t.text     "extentions", limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "events", ["actor_id"], name: "index_events_on_actor_id", using: :btree
  add_index "events", ["project_id"], name: "index_events_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "team_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "projects", ["team_id"], name: "index_projects_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "description",  limit: 65535
    t.date     "deadline"
    t.boolean  "completed",                  default: false, null: false
    t.integer  "creator_id",   limit: 4,                     null: false
    t.integer  "executor_id",  limit: 4
    t.integer  "completer_id", limit: 4
    t.integer  "project_id",   limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "todos", ["completer_id"], name: "index_todos_on_completer_id", using: :btree
  add_index "todos", ["creator_id"], name: "index_todos_on_creator_id", using: :btree
  add_index "todos", ["executor_id"], name: "index_todos_on_executor_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "team_id",                limit: 4
    t.string   "name",                   limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
