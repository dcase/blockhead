# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def plural_class_name(*args, &block)
  ActionController::RecordIdentifier.plural_class_name(*args, &block)
  end
  
  def singular_class_name(*args, &block)
  ActionController::RecordIdentifier.singular_class_name(*args, &block)
  end
  
  def get_menu_sections
    unless authorized?
      Section.all(:order => :position, :conditions => { :published => true, :parent_id => nil })
    else
      Section.all(:order => :position, :conditions => { :parent_id => nil })
    end
  end
end
