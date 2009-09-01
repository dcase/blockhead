class Partial < ActiveRecord::Base
  has_one :content, :as => :contentable, :dependent => :destroy
  
  validates_presence_of :controller, :name
  
  accepts_nested_attributes_for :content
  
  attr_accessor :contentable_class
  
  def self.display_name
    "Rails Partial"
  end
  
end
