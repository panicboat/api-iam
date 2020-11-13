class CreateMapUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :map_user_roles, comment: '管理者ロール' do |t|
      t.string  :user_id,   null: false,  comment: '管理者ID'
      t.string  :role_id,   null: false,  comment: 'ロールID'

      t.timestamps
    end
    add_foreign_key :map_user_roles, :users
    add_foreign_key :map_user_roles, :roles
    add_index       :map_user_roles, %i[user_id role_id], unique: true
  end
end
