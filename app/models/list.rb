class List < ActiveRecord::Base
  has_one :content, :as => :contentable, :dependent => :destroy
  has_many :list_items, :dependent => :destroy, :order => :position
  
  accepts_nested_attributes_for :content
  accepts_nested_attributes_for :list_items, :reject_if => proc { |attributes| attributes['output'].blank? }, :allow_destroy => true
  
  
  attr_accessor :contentable_class
  
  validate :at_least_one
  
  def self.display_name
    "Plain List"
  end
  
  private
  
  def at_least_one
    if self.list_items.blank?
      errors.add_to_base(": Please add at least one item to the list.")
    end
  end

end
