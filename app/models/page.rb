class Page < ActiveRecord::Base
  belongs_to :section
  has_many :blocks, :dependent => :destroy, :order => :position
  belongs_to :seo_profile
  
  acts_as_list :scope => :section
  
  validates_presence_of :short_name
  
  def before_save
    if long_name.blank?
      long_name = short_name
    end
  end
end
