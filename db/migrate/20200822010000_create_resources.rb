class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources, comment: 'リソース' do |t|
      t.string  :statement_id,  null: false,  comment: 'ステートメントID', limit: 36
      t.string  :name,          null: false,  comment: '名前'

      t.timestamps
    end
    add_foreign_key :resources, :statements
    add_index       :resources, %i[statement_id name], unique: true
  end
end
