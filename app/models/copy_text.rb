class CopyText < ActiveRecord::Base
  has_one :content, :as => :contentable, :dependent => :destroy
  
  validates_presence_of :output
  
  accepts_nested_attributes_for :content
  
  attr_accessor :contentable_class
  
  def self.display_name
    "Text"
  end
end
