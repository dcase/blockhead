xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Insight Strategy Advisors"
    xml.description "News feed from Insight Strategy Advisors"
    xml.link blog_posts_url(@blog, :format => :rss)
    
    for post in @posts
      xml.item do
        xml.title post.title
        xml.description textilize(post.body)
        xml.pubDate post.published_on.to_s(:rfc822)
        xml.link blog_post_url(@blog, post)
        xml.guid blog_post_url(@blog, post)
      end
    end
  end
end