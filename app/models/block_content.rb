class BlockContent < ActiveRecord::Base
  belongs_to :block
  belongs_to :content
  
  acts_as_list :scope => :block
  
  attr_accessor :do_add
end
