class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services, id: false, comment: 'サービス' do |t|
      t.string  :id,           null: false,  comment: 'サービスID', primary_key: true, limit: 36
      t.string  :name,         null: false,  comment: '名前'
      t.string  :description,  null: true,   comment: '説明'

      t.timestamps
    end
    add_index :services, [:name], unique: true
  end
end
