class Blog < ActiveRecord::Base
  has_one :content, :as => :contentable, :dependent => :destroy
  has_many :posts, :dependent => :destroy, :order => "published_on DESC, created_at DESC"
  
  accepts_nested_attributes_for :content
  accepts_nested_attributes_for :posts, :reject_if => proc { |attributes| attributes['body'].blank? }, :allow_destroy => true
  
  
  attr_accessor :contentable_class
  
  validates_presence_of :title
  validate :at_least_one
  
  def self.display_name
    "Blog"
  end
  
  def recent_posts(number = 3)
    self.posts.find(:all, :limit => number, :conditions => { :published => true })
  end
  
  def self.recent_posts(id, number = 3)
    blog = Blog.find(id)
    posts = blog.posts.find(:all, :limit => number, :conditions => { :published => true })
    return posts
  end

  private
  
  def at_least_one
    if self.posts.blank?
      errors.add_to_base(": Please add your first post.")
    end
  end
  
end
