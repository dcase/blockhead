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
  
  def section_level(sections)
    output = []
    sections.each do |section|
      node = [section.short_name]
      unless section.pages.blank?
        pages = section.pages.all.collect {|p|
          [p.short_name,section_page_path(section,p)]
        }
        node << pages
      end
      unless section.children.blank?
        node << section_level(section.children)
      end
      output << node
    end
    return output
  end
  
  def get_sections_and_pages_array
    sections = Section.roots
    levels = section_level(sections)
    return levels
  end
  
  def page_breadcrumb(page)
    section = page.section
    output = ""
    sections = section.ancestors
    sections << section
    sections.each do |a|
      output += a.short_name + " > "
    end
    output += page.short_name
    
    return output
  end
        
end
