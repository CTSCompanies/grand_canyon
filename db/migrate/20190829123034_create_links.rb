class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      t.integer :hits
      t.string :created_by

      t.timestamps null: false
    end
  end
end
