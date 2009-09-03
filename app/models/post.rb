class Post < ActiveRecord::Base
  belongs_to :blog
  
  validates_presence_of :title, :published_on, :body
end
