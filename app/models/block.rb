class Block < ActiveRecord::Base
  belongs_to :page
  has_many :block_contents, :dependent => :destroy
  has_many :contents, :through => :block_contents, :dependent => :destroy
  has_one :scroll, :as => :scrollable, :dependent => :destroy
  
  accepts_nested_attributes_for :contents, :block_contents
  
  acts_as_list :scope => :parent_id
  acts_as_tree :order => :position
  
  validates_presence_of :short_name
  validate :no_tabs_with_content
  
  def before_save
    if self.long_name.blank?
      self.long_name = self.short_name
    end
  end
  
  private
  
  def no_tabs_with_content
    if nested_blocks_as_tabs?
      unless contents.blank?
        errors.add_to_base("Block can't be tabbed if it has content.")
      end
    end
  end
end
