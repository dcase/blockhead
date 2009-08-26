class AddIsHtmlToCopyTexts < ActiveRecord::Migration
  def self.up
    add_column :copy_texts, :is_html, :boolean, :default => 0
  end

  def self.down
    remove_column :copy_texts, :is_html
  end
end
