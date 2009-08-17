class AddPageIdToBlocks < ActiveRecord::Migration
  def self.up
    add_column :blocks, :page_id, :integer
  end

  def self.down
    remove_column :blocks, :page_id
  end
end
