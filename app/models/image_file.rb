class ImageFile < ActiveRecord::Base
  has_attached_file :image, :styles => { :small => "150x>", :medium => "300x>", :large => "450x>", :thumb => "100x100#" }
  
  validates_presence_of :title
  validates_attachment_presence :image
end
