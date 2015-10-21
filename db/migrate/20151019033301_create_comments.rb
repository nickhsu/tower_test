class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :todo, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
