class BlockContent < ActiveRecord::Base
  belongs_to :block
  belongs_to :content
  
  attr_accessor :do_add
end
