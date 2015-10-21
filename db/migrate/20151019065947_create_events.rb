class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :actor_id, null: false
      t.references :project, index: true
      t.string :event_type, null: false
      t.text :extentions

      t.timestamps null: false
    end

    add_index :events, :actor_id
  end
end
