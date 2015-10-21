class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.references :user, index: true
      t.references :project, index: true
      t.string :role

      t.timestamps null: false
    end
  end
end
