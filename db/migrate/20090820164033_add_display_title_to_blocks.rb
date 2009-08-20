class AddDisplayTitleToBlocks < ActiveRecord::Migration
  def self.up
    add_column :blocks, :display_title, :boolean, :default => 0
  end

  def self.down
    remove_column :blocks, :display_title
  end
end
