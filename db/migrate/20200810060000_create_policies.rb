class CreatePolicies < ActiveRecord::Migration[6.0]
  def change
    create_table :policies, id: false, comment: 'ポリシー' do |t|
      t.string  :id,          null: false,  comment: 'ポリシーID', primary_key: true, limit: 36
      t.string  :name,        null: false,  comment: '名前'
      t.string  :description, null: true,   comment: '説明'
      t.boolean :inline,      null: false,  comment: 'インライン', default: false
      t.integer :owner,       null: false,  comment: '所有者', limit: 3

      t.timestamps
    end
  end
end
