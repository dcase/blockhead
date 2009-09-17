class Section < ActiveRecord::Base
  has_many :pages, :dependent => :destroy, :order => :position
  belongs_to :seo_profile
  
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
      unless UserSession.find
        return self, self.pages.find(:first, :conditions => { :published => true})
      else
        return self, self.pages.first
      end
    else
      return self, false
    end
  end
end
