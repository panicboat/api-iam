class CreateStatements < ActiveRecord::Migration[6.0]
  def change
    create_table :statements, id: false, comment: 'ステートメント' do |t|
      t.string  :id,        null: false,  comment: 'ステートメントID', primary_key: true, limit: 36
      t.string  :policy_id, null: false,  comment: 'ポリシーID', limit: 36
      t.integer :effect,    null: false,  comment: '効果', limit: 3

      t.timestamps
    end
    add_foreign_key :statements, :policies
  end
end
