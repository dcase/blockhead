class AddWidthAndHeightToBlocks < ActiveRecord::Migration
  def self.up
    add_column :blocks, :width, :integer
    add_column :blocks, :height, :integer
  end

  def self.down
    remove_column :blocks, :height
    remove_column :blocks, :width
  end
end
