class AddDisplayTitleToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :display_title, :boolean, :default => 0
  end

  def self.down
    remove_column :sections, :display_title
  end
end
