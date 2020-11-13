class CreateMapGroupRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :map_group_roles, comment: 'グループロール' do |t|
      t.string  :group_id,  null: false,  comment: 'グループID'
      t.string  :role_id,   null: false,  comment: 'ロールID'

      t.timestamps
    end
    add_foreign_key :map_group_roles, :groups
    add_foreign_key :map_group_roles, :roles
    add_index       :map_group_roles, %i[group_id role_id], unique: true
  end
end
