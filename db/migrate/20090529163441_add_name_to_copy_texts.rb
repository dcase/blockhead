class AddNameToCopyTexts < ActiveRecord::Migration
  def self.up
    add_column :copy_texts, :name, :string
  end

  def self.down
    remove_column :copy_texts, :name
  end
end
