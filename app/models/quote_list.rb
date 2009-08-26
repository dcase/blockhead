class QuoteList < ActiveRecord::Base
  has_one :content, :as => :contentable, :dependent => :destroy
  has_many :quotes, :dependent => :destroy, :order => :position
  
  accepts_nested_attributes_for :content
  accepts_nested_attributes_for :quotes, :reject_if => proc { |attributes| attributes['output'].blank? }, :allow_destroy => true
  
  
  attr_accessor :contentable_class
  
  def self.display_name
    "Quote List"
  end
end
