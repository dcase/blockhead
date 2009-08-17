class SeoProfile < ActiveRecord::Base
  has_many :pages, :dependent => :nullify
  
  validates_presence_of :name, :title, :description, :keywords, :h1, :h2
  
  
  def after_destroy
    if id == 1
      raise "Can't delete the default profile"
    end
  end
end
