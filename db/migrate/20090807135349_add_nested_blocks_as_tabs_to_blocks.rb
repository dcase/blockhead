class AddNestedBlocksAsTabsToBlocks < ActiveRecord::Migration
  def self.up
    add_column :blocks, :nested_blocks_as_tabs, :boolean, :default => 0
  end

  def self.down
    remove_column :blocks, :nested_blocks_as_tabs
  end
end
