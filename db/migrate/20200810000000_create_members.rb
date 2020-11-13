class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members, id: false, comment: 'メンバー' do |t|
      t.string  :id,           null: false, comment: 'メンバーID', primary_key: true, limit: 36
      t.string  :email,        null: false, comment: 'メールアドレス'
      t.string  :name,         null: false, comment: '名前'
      t.string  :image,        null: true,  comment: 'アイコン'
      t.string  :description,  null: true,  comment: 'コメント'

      t.timestamps
    end
    add_index :members, [:email], unique: true
  end
end
