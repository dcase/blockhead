class RenamePublishOnToPublishedOnInPosts < ActiveRecord::Migration
  def self.up
    rename_column :posts, :publish_on, :published_on
  end

  def self.down
    rename_column :posts, :published_on, :publish_on
  end
end
