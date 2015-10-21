class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.boolean :completed, null: false, default: false
      t.integer :creator_id, null: false
      t.integer :executor_id
      t.integer :completer_id
      t.references :project

      t.timestamps null: false
    end

    add_index :todos, :creator_id
    add_index :todos, :executor_id
    add_index :todos, :completer_id
  end
end
