class AddCssClassesToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :css_classes, :string
  end

  def self.down
    remove_column :contents, :css_classes
  end
end
