# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_22_020000) do

  create_table "actions", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "アクション", force: :cascade do |t|
    t.string "service_id", limit: 36, null: false, comment: "サービスID"
    t.string "name", null: false, comment: "名前"
    t.string "description", comment: "説明"
    t.integer "access_level", limit: 3, null: false, comment: "アクセスレベル"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id", "name"], name: "index_actions_on_service_id_and_name", unique: true
  end

  create_table "groups", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "グループ", force: :cascade do |t|
    t.string "name", null: false, comment: "名前"
    t.string "description", comment: "説明"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "map_group_policies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "グループポリシー", force: :cascade do |t|
    t.string "group_id", limit: 36, null: false, comment: "グループID"
    t.string "policy_id", limit: 36, null: false, comment: "ポリシーID"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id", "policy_id"], name: "index_map_group_policies_on_group_id_and_policy_id", unique: true
    t.index ["policy_id"], name: "fk_rails_2f1efda71d"
  end

  create_table "map_group_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "グループロール", force: :cascade do |t|
    t.string "group_id", limit: 36, null: false, comment: "グループID"
    t.string "role_id", limit: 36, null: false, comment: "ロールID"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id", "role_id"], name: "index_map_group_roles_on_group_id_and_role_id", unique: true
    t.index ["role_id"], name: "fk_rails_0133cb85d5"
  end

  create_table "map_group_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "グループ管理者", force: :cascade do |t|
    t.string "group_id", limit: 36, null: false, comment: "グループID"
    t.string "user_id", limit: 36, null: false, comment: "管理者ID"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id", "user_id"], name: "index_map_group_users_on_group_id_and_user_id", unique: true
    t.index ["user_id"], name: "fk_rails_015ae8afd1"
  end

  create_table "map_role_policies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "ロールポリシー", force: :cascade do |t|
    t.string "role_id", limit: 36, null: false, comment: "ロールID"
    t.string "policy_id", limit: 36, null: false, comment: "ポリシーID"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["policy_id"], name: "fk_rails_369370d5df"
    t.index ["role_id", "policy_id"], name: "index_map_role_policies_on_role_id_and_policy_id", unique: true
  end

  create_table "map_statement_actions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "ステートメントアクション", force: :cascade do |t|
    t.string "statement_id", limit: 36, null: false, comment: "ステートメントID"
    t.string "action", null: false, comment: "アクション"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["statement_id", "action"], name: "index_map_statement_actions_on_statement_id_and_action", unique: true
  end

  create_table "map_user_policies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "管理者ポリシー", force: :cascade do |t|
    t.string "user_id", limit: 36, null: false, comment: "管理者ID"
    t.string "policy_id", limit: 36, null: false, comment: "ポリシーID"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["policy_id"], name: "fk_rails_bca27aa193"
    t.index ["user_id", "policy_id"], name: "index_map_user_policies_on_user_id_and_policy_id", unique: true
  end

  create_table "map_user_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "管理者ロール", force: :cascade do |t|
    t.string "user_id", limit: 36, null: false, comment: "管理者ID"
    t.string "role_id", limit: 36, null: false, comment: "ロールID"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "fk_rails_04aebf5b81"
    t.index ["user_id", "role_id"], name: "index_map_user_roles_on_user_id_and_role_id", unique: true
  end

  create_table "policies", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "ポリシー", force: :cascade do |t|
    t.string "name", null: false, comment: "名前"
    t.string "description", comment: "説明"
    t.boolean "inline", default: false, null: false, comment: "インライン"
    t.integer "owner", limit: 3, null: false, comment: "所有者"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "resources", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "リソース", force: :cascade do |t|
    t.string "statement_id", limit: 36, null: false, comment: "ステートメントID"
    t.string "name", null: false, comment: "名前"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["statement_id", "name"], name: "index_resources_on_statement_id_and_name", unique: true
  end

  create_table "roles", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "ロール", force: :cascade do |t|
    t.string "name", null: false, comment: "名前"
    t.string "description", comment: "説明"
    t.integer "owner", limit: 3, null: false, comment: "所有者"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "services", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "サービス", force: :cascade do |t|
    t.string "name", null: false, comment: "名前"
    t.string "description", comment: "説明"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_services_on_name", unique: true
  end

  create_table "statements", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "ステートメント", force: :cascade do |t|
    t.string "policy_id", limit: 36, null: false, comment: "ポリシーID"
    t.integer "effect", limit: 3, null: false, comment: "効果"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["policy_id"], name: "fk_rails_a0e3005828"
  end

  create_table "users", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "管理者情報", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "name", null: false, comment: "名前"
    t.string "image", comment: "アイコン"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "actions", "services"
  add_foreign_key "map_group_policies", "groups"
  add_foreign_key "map_group_policies", "policies"
  add_foreign_key "map_group_roles", "groups"
  add_foreign_key "map_group_roles", "roles"
  add_foreign_key "map_group_users", "groups"
  add_foreign_key "map_group_users", "users"
  add_foreign_key "map_role_policies", "policies"
  add_foreign_key "map_role_policies", "roles"
  add_foreign_key "map_statement_actions", "statements"
  add_foreign_key "map_user_policies", "policies"
  add_foreign_key "map_user_policies", "users"
  add_foreign_key "map_user_roles", "roles"
  add_foreign_key "map_user_roles", "users"
  add_foreign_key "resources", "statements"
  add_foreign_key "statements", "policies"
end
