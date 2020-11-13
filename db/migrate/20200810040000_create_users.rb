class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false, comment: '管理者情報' do |t|
      t.string  :id,     null: false,  comment: '管理者ID', primary_key: true, limit: 36
      t.string  :email,  null: false,  comment: 'メールアドレス'
      t.string  :name,   null: false,  comment: '名前'
      t.string  :image,  null: true,   comment: 'アイコン'

      t.timestamps
    end
    add_index :users, [:email], unique: true
  end
end
