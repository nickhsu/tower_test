class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :actor_id, null: false
      t.string :event_type, null: false
      t.references :todo
      t.text :extentions

      t.timestamps null: false
    end
  end
end
