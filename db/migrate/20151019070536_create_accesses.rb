class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.references :user
      t.references :project
      t.string :role

      t.timestamps null: false
    end
  end
end
