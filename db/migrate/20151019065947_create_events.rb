class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.text :extentions

      t.timestamps null: false
    end
  end
end
