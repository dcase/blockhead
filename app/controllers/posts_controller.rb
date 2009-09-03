class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    @blog = Blog.find(params[:blog_id])
    @section = @blog.content.blocks.first.page.section
    conditions = ""
    
    unless params[:year].blank?
      conditions += "YEAR(published_on) = :year"
      unless params[:month].blank?
        conditions += " AND MONTH(published_on) = :month"
        unless params[:day].blank?
          conditions += " AND DAY(published_on) = :day"
        end
      end
    end
    
    unless authorized?
      conditions += (conditions.blank? ? "published = 1" : " AND published = 1")
    end
       
    @posts = @blog.posts.find(:all, :conditions => [condiitions, params]) 
   
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @posts }
      format.rss
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @blog = Blog.find(params[:blog_id])
    @section = @blog.content.blocks.first.page.section
    @post = @blog.posts.find(params[:id])
    
    @first_post = @blog.posts.find(:first, :conditions => { :published => true }, :order => "published_on ASC" )

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @blog = Blog.find(params[:blog_id])
    @section = @blog.content.blocks.first.page.section
    @post = @blog.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @blog = Blog.find(params[:blog_id])
    @section = @blog.content.blocks.first.page.section
    @post = @blog.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @blog = Blog.find(params[:blog_id])
    @section = @blog.content.blocks.first.page.section
    @post = @blog.posts.build(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to([@blog,@post]) }
        format.js { render :partial => "blogs/post", :locals => { :post => @post } }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @blog = Blog.find(params[:blog_id])
    @section = @blog.content.blocks.first.page.section
    @post = @blog.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to([@blog,@post]) }
        format.js { render :action => "show" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @blog = Blog.find(params[:blog_id])
    @section = @blog.content.blocks.first.page.section
    @post = @blog.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.js { render :js => "$('#post_#{params[:id]}').remove();"}
      format.xml  { head :ok }
    end
  end
end
