# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090807135349) do

  create_table "block_contents", :force => true do |t|
    t.integer  "block_id"
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blocks", :force => true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.integer  "parent_id"
    t.integer  "position"
    t.string   "css_classes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_id"
    t.boolean  "nested_blocks_as_tabs", :default => false
  end

  create_table "contents", :force => true do |t|
    t.integer  "contentable_id"
    t.string   "contentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "css_classes"
  end

  create_table "copy_texts", :force => true do |t|
    t.text     "output"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_entries", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_files", :force => true do |t|
    t.string   "title"
    t.string   "caption"
    t.text     "description"
    t.string   "link_url"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_items", :force => true do |t|
    t.string   "output"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "list_id"
  end

  create_table "lists", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.integer  "section_id"
    t.integer  "position"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seo_profile_id"
  end

  create_table "scrolls", :force => true do |t|
    t.integer  "width"
    t.integer  "height"
    t.boolean  "vertical"
    t.integer  "scrollable_id"
    t.string   "scrollable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.integer  "position"
    t.integer  "parent_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seo_profiles", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "keywords"
    t.text     "description"
    t.string   "h1"
    t.string   "h2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",               :default => "",      :null => false
    t.string   "email",               :default => "",      :null => false
    t.string   "crypted_password",    :default => "",      :null => false
    t.string   "password_salt",       :default => "",      :null => false
    t.string   "persistence_token",   :default => "",      :null => false
    t.string   "single_access_token", :default => "",      :null => false
    t.string   "perishable_token",    :default => "",      :null => false
    t.integer  "login_count",         :default => 0,       :null => false
    t.integer  "failed_login_count",  :default => 0,       :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "role",                :default => "admin", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
