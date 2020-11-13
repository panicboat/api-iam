class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles, id: false, comment: 'ロール' do |t|
      t.string  :id,          null: false,  comment: 'ロールID', primary_key: true, limit: 36
      t.string  :name,        null: false,  comment: '名前'
      t.string  :description, null: true,   comment: '説明'
      t.integer :owner,       null: false,  comment: '所有者', limit: 3

      t.timestamps
    end
    add_index :roles, [:name], unique: true
  end
end
