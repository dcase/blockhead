class QuoteList < ActiveRecord::Base
  has_one :content, :as => :contentable, :dependent => :destroy
  has_many :quotes, :dependent => :destroy, :order => :position
  
  accepts_nested_attributes_for :content
  accepts_nested_attributes_for :quotes, :reject_if => proc { |attributes| attributes['output'].blank? }, :allow_destroy => true
  
  
  attr_accessor :contentable_class
  
  validate :at_least_one
  
  def self.display_name
    "Quote List"
  end
  
  private
  
  def at_least_one
    if self.quotes.blank?
      errors.add_to_base(": Please add at least one quote to the list.")
    end
  end
end
