class RenameLinkToFeedUrlInFeeds < ActiveRecord::Migration
  def self.up
    rename_column :feeds, :link, :feed_url
  end

  def self.down
    rename_column :feeds, :feed_url, :link
  end
end
