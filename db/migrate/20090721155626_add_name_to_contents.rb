class AddNameToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :name, :string
  end

  def self.down
    remove_column :contents, :name
  end
end
