class Section < ActiveRecord::Base
  has_many :pages, :dependent => :destroy, :order => :position
  
  acts_as_list :scope => :parent_id
  acts_as_tree :order => :position
  
  validates_presence_of :short_name
  
  def before_save
    if self.long_name.blank?
      self.long_name = self.short_name
    end
  end
  
  def set_root
    ancestors = self.ancestors
    unless ancestors.empty? 
      root = ancestors.last
    else
      root = self
    end
  end
  
  def find_first_page
    if self.pages.empty? && self.children.empty?
      return self, false
    elsif self.pages.empty? && !self.children.empty?
      return self.children.first.find_first_page
    elsif !self.pages.empty?
      return self, self.pages.first
    else
      return self, false
    end
  end
end
