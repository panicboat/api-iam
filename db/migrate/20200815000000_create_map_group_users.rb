class CreateMapGroupUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :map_group_users, comment: 'グループ管理者' do |t|
      t.string  :group_id,  null: false,  comment: 'グループID'
      t.string  :user_id,   null: false,  comment: '管理者ID'

      t.timestamps
    end
    add_foreign_key :map_group_users, :groups
    add_foreign_key :map_group_users, :users
    add_index       :map_group_users, %i[group_id user_id], unique: true
  end
end
