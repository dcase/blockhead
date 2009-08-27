class User < ActiveRecord::Base
  acts_as_authentic
  
  attr_accessor :edit_self
  
  def after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end
