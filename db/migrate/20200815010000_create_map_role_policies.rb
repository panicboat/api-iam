class CreateMapRolePolicies < ActiveRecord::Migration[6.0]
  def change
    create_table :map_role_policies, comment: 'ロールポリシー' do |t|
      t.string  :role_id,   null: false,  comment: 'ロールID'
      t.string  :policy_id, null: false,  comment: 'ポリシーID'

      t.timestamps
    end
    add_foreign_key :map_role_policies, :roles
    add_foreign_key :map_role_policies, :policies
    add_index       :map_role_policies, %i[role_id policy_id], unique: true
  end
end
