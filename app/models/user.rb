class User < ActiveRecord::Base
  acts_as_authentic
  
  def after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end
