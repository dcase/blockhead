class AddDisplayTitleToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :display_title, :boolean, :default => 0
  end

  def self.down
    remove_column :pages, :display_title
  end
end
