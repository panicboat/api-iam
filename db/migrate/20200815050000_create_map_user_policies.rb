class CreateMapUserPolicies < ActiveRecord::Migration[6.0]
  def change
    create_table :map_user_policies, comment: '管理者ポリシー' do |t|
      t.string  :user_id,   null: false,  comment: '管理者ID', limit: 36
      t.string  :policy_id, null: false,  comment: 'ポリシーID', limit: 36

      t.timestamps
    end
    add_foreign_key :map_user_policies, :users
    add_foreign_key :map_user_policies, :policies
    add_index       :map_user_policies, %i[user_id policy_id], unique: true
  end
end
