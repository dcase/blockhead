class List < ActiveRecord::Base
  has_one :content, :as => :contentable, :dependent => :destroy
  has_many :list_items, :dependent => :destroy, :order => :position
  
  accepts_nested_attributes_for :content
  accepts_nested_attributes_for :list_items, :reject_if => proc { |attributes| attributes['output'].blank? }, :allow_destroy => true
  
  
  attr_accessor :contentable_class
  
  def self.display_name
    "Plain List"
  end
  
end
