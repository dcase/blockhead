class AddDisplayCountToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :display_count, :integer, :default => 10
  end

  def self.down
    remove_column :feeds, :display_count
  end
end
