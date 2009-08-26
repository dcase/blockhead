class Quote < ActiveRecord::Base
  belongs_to :quote_list
  
  acts_as_list :scope => :quote_list
  
  validates_presence_of :title, :output, :attributed_to
end
