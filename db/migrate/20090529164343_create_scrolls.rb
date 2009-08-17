class CreateScrolls < ActiveRecord::Migration
  def self.up
    create_table :scrolls do |t|
      t.integer :width
      t.integer :height
      t.boolean :vertical
      t.integer :scrollable_id
      t.string :scrollable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :scrolls
  end
end
