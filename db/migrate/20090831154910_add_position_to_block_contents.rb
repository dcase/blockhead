class AddPositionToBlockContents < ActiveRecord::Migration
  def self.up
    add_column :block_contents, :position, :integer
  end

  def self.down
    remove_column :block_contents, :position
  end
end
