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
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
