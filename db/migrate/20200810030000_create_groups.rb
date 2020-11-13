class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups, id: false, comment: 'グループ' do |t|
      t.string  :id,           null: false,  comment: 'グループID', primary_key: true, limit: 36
      t.string  :name,         null: false,  comment: '名前'
      t.string  :description,  null: true,   comment: '説明'

      t.timestamps
    end
    add_index :groups, [:name], unique: true
  end
end
