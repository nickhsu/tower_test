class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.integer :creator_id, null: false
      t.integer :executor_id

      t.timestamps null: false
    end
  end
end
