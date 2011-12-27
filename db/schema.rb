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

ActiveRecord::Schema.define(:version => 20111227185945) do

  create_table "addresses", :force => true do |t|
    t.integer  "user_id"
    t.string   "street"
    t.string   "city"
    t.string   "postcode"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.integer  "author_id"
    t.string   "title"
    t.integer  "exemplars"
    t.boolean  "digitized",  :default => false
    t.text     "notes"
    t.string   "tags"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bosses", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_3"
    t.string   "post_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clerks", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_3"
    t.string   "post_code"
    t.float    "salary"
    t.boolean  "subject_to_lay_off"
    t.integer  "boss_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_centers", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "infrastructures", :force => true do |t|
    t.string   "label"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grid",       :default => "unspecified"
    t.string   "cluster",    :default => "unspecified"
    t.boolean  "editable",   :default => true
    t.string   "domain"
  end

  create_table "metrics", :force => true do |t|
    t.text    "label"
    t.text    "value"
    t.integer "timestamp"
    t.integer "node_id"
    t.string  "unit"
  end

  create_table "netzke_component_states", :force => true do |t|
    t.string   "component"
    t.integer  "user_id"
    t.integer  "role_id"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "netzke_component_states", ["component"], :name => "index_netzke_component_states_on_component"
  add_index "netzke_component_states", ["role_id"], :name => "index_netzke_component_states_on_role_id"
  add_index "netzke_component_states", ["user_id"], :name => "index_netzke_component_states_on_user_id"

  create_table "node_racks", :force => true do |t|
    t.integer  "data_center_id"
    t.text     "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "node_types", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", :force => true do |t|
    t.integer  "node_rack_id"
    t.string   "hostname"
    t.integer  "operating_system_id"
    t.integer  "node_type_id",        :default => 1
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.string   "mac_address"
    t.integer  "infrastructure_id",   :default => 2
    t.string   "label",               :default => ""
  end

  create_table "operating_systems", :force => true do |t|
    t.string   "label"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tableless", :force => true do |t|
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
