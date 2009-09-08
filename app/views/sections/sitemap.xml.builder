xml.instruct! :xml, :version => "1.0" 
xml.urlset :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  for section in Section.roots
    if section.published?
      build_sitemap(section,xml)
    end
  end
end