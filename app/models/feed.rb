class Feed < ActiveRecord::Base
  has_one :content, :as => :contentable, :dependent => :destroy
  has_many :feed_entries, :dependent => :destroy, :order => "published_at DESC"
  
  validates_presence_of :feed_url
  validates_uniqueness_of :feed_url
  validate :real_feed?
  
  accepts_nested_attributes_for :content
  
  attr_accessor :contentable_class
  
  def self.display_name
    "RSS Feed"
  end
  
  def before_save
    feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
    self.title = feed.title
    self.description = feed.summary if defined?(feed.summary)
  end
  
  def after_save
    self.update_from_feed
  end
  
  def update_from_feed
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries, id)
  end

  def update_from_feed_continuously(delay_minutes = 15)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries, id)
    loop do
      sleep delay_minutes * 60
      feed = Feedzirra::Feed.update(feed)
      add_entries(feed.new_entries, id) if feed.updated?
    end
  end
  
  def self.update_all_feeds
    Feed.all.each do |f|
      feed = Feedzirra::Feed.fetch_and_parse(f.feed_url)
      if feed.respond_to?('entries')
        f.add_entries(feed.entries, f.id) unless feed.entries.blank?
      end
    end
  end

  def add_entries(entries, feed_id)
    entries.each do |entry|
      unless FeedEntry.exists? :guid => entry.id
        FeedEntry.create!(
          :name         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id,
          :feed_id      => feed_id
        )
      end
    end
  end
  
  private
  
  def real_feed?
    feed = Feedzirra::Feed.fetch_and_parse(self.feed_url);
    unless defined?(feed.title)
      errors.add_to_base("This feed has no title! Please check that the URL is a real feed.")
    end
  end
end
