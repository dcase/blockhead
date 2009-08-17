class Content < ActiveRecord::Base
  has_many :block_contents, :dependent => :destroy
  has_many :blocks, :through => :block_contents
  belongs_to :contentable, :polymorphic => true, :dependent => :destroy
  
  accepts_nested_attributes_for :contentable
  
  validates_presence_of :name
  
  def build_contentable(params)
      if defined? params["contentable_class"]
        unless params["id"].blank?
          content = Object::const_get(params["contentable_class"]).find(params["id"].to_i)
          content.update_attributes(params)
          content.save
        else
          content = Object::const_get(params["contentable_class"]).create(params)
          self.contentable = content
          self.save
        end
      end
  end
          
end
