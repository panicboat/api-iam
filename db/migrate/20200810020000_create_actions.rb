class CreateActions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions, id: false, comment: 'アクション' do |t|
      t.string  :id,           null: false,  comment: 'アクションID', primary_key: true, limit: 36
      t.string  :service_id,   null: false,  comment: 'サービスID', limit: 36
      t.string  :name,         null: false,  comment: '名前'
      t.string  :description,  null: true,   comment: '説明'
      t.integer :access_level, null: false,  comment: 'アクセスレベル', limit: 3

      t.timestamps
    end
    add_foreign_key :actions, :services
    add_index       :actions, %i[service_id name], unique: true
  end
end
