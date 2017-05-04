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

ActiveRecord::Schema.define(version: 20170504061912) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",     null: false
    t.integer  "target_id"
    t.integer  "target_type"
    t.integer  "action_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "average_caches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rater_id"
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "avg",           limit: 24, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "left",                   null: false
    t.integer  "right",                  null: false
    t.string   "name",                   null: false
    t.integer  "level",      default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "data_fingerprint"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type", using: :btree
  end

  create_table "condition_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "condition_id", null: false
    t.string   "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["condition_id", "value"], name: "index_condition_details_on_condition_id_and_value", unique: true, using: :btree
    t.index ["condition_id"], name: "index_condition_details_on_condition_id", using: :btree
  end

  create_table "conditions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_ingredients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "food_id",                  null: false
    t.integer  "ingredient_id",            null: false
    t.float    "value",         limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["food_id"], name: "index_food_ingredients_on_food_id", using: :btree
    t.index ["ingredient_id"], name: "index_food_ingredients_on_ingredient_id", using: :btree
  end

  create_table "foods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                         null: false
    t.text     "cooking_method", limit: 65535
    t.float    "calorie",        limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "image"
  end

  create_table "form_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hashtags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "ingredients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",        null: false
    t.string   "inscription"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",     null: false
    t.integer  "target_id"
    t.string   "target_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "overall_averages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "overall_avg",   limit: 24, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "category_id",               null: false
    t.string   "title",                     null: false
    t.text     "content",     limit: 65535, null: false
    t.string   "type"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "image"
    t.index ["category_id"], name: "index_posts_on_category_id", using: :btree
  end

  create_table "rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rater_id"
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "stars",         limit: 24, null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
    t.index ["rater_id"], name: "index_rates_on_rater_id", using: :btree
  end

  create_table "rating_caches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "cacheable_type"
    t.integer  "cacheable_id"
    t.float    "avg",            limit: 24, null: false
    t.integer  "qty",                       null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "target_conditions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "target_id",                           null: false
    t.integer  "condition_detail_id",                 null: false
    t.boolean  "is_match",            default: false
    t.string   "type"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["condition_detail_id", "target_id", "type"], name: "add_indexarget_condition", unique: true, using: :btree
    t.index ["condition_detail_id"], name: "index_target_conditions_on_condition_detail_id", using: :btree
  end

  create_table "target_hashtags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "hashtag_id",  null: false
    t.integer  "target_id",   null: false
    t.string   "target_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["hashtag_id"], name: "index_target_hashtags_on_hashtag_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "gender",                 default: 1,  null: false
    t.string   "avatar"
    t.datetime "birthday"
    t.integer  "occupation"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  add_foreign_key "identities", "users"
end
