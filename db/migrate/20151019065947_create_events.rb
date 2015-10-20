class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :actor_id, null: false
      t.references :project
      t.string :event_type, null: false
      t.text :extentions

      t.timestamps null: false
    end
  end
end
