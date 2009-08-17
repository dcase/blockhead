class Scroll < ActiveRecord::Base
  belongs_to :scrollable, :polymorphic => true
end
