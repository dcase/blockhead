# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def textilize_without_paragraph(text)
    textiled = textilize(text)
    if textiled[0..2] == "<p>" then textiled = textiled[3..-1] end
    if textiled[-4..-1] == "</p>" then textiled = textiled[0..-5] end
    return textiled
  end
  
  def plural_class_name(*args, &block)
  ActionController::RecordIdentifier.plural_class_name(*args, &block)
  end
  
  def singular_class_name(*args, &block)
  ActionController::RecordIdentifier.singular_class_name(*args, &block)
  end
  
  def get_menu_sections(section = nil)
    conditions = {}
    section.blank? ? conditions.merge!({ :parent_id => nil }) : conditions.merge!({ :parent_id => section })
    conditions.merge!({ :published => true }) unless authorized?
    Section.all(:order => :position, :conditions => conditions )
  end
end
