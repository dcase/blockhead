class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.string :short_name
      t.string :long_name
      t.integer :parent_id
      t.integer :position
      t.string :css_classes

      t.timestamps
    end
  end

  def self.down
    drop_table :blocks
  end
end
