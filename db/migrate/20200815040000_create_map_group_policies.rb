class CreateMapGroupPolicies < ActiveRecord::Migration[6.0]
  def change
    create_table :map_group_policies, comment: 'グループポリシー' do |t|
      t.string  :group_id,  null: false,  comment: 'グループID', limit: 36
      t.string  :policy_id, null: false,  comment: 'ポリシーID', limit: 36

      t.timestamps
    end
    add_foreign_key :map_group_policies, :groups
    add_foreign_key :map_group_policies, :policies
    add_index       :map_group_policies, %i[group_id policy_id], unique: true
  end
end
