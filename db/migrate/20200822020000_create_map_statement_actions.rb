class CreateMapStatementActions < ActiveRecord::Migration[6.0]
  def change
    create_table :map_statement_actions, comment: 'ステートメントアクション' do |t|
      t.string  :statement_id,  null: false,  comment: 'ステートメントID', limit: 36
      t.string  :action,        null: false,  comment: 'アクション'

      t.timestamps
    end
    add_foreign_key :map_statement_actions, :statements
    add_index       :map_statement_actions, %i[statement_id action], unique: true
  end
end
