class RemoveNameFromCopyTexts < ActiveRecord::Migration
  def self.up
    remove_column :copy_texts, :name
  end

  def self.down
    add_column :copy_texts, :name, :string
  end
end
