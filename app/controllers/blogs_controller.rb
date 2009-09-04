class BlogsController < ApplicationController
  # GET /blogs
  # GET /blogs.xml
  def index
    @blogs = Blog.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.xml
  def show
    @blog = Blog.find(params[:id])
    @page = @blog.content.blocks.first.page
    @section = @page.section
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
       
    unless conditions.blank?
      @posts = @blog.posts.find(:all, :conditions => [conditions, params])
    else
      @posts = @blog.posts.all
    end
    
    @first_post = @blog.posts.find(:first, :conditions => { :published => true }, :order => "published_on ASC" )

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.xml
  def new
    @blog = Blog.new
    @post = @blog.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
    @post = @blog.posts.build if @blog.posts.blank?
  end

  # POST /blogs
  # POST /blogs.xml
  def create
    @blog = Blog.new(params[:blog])

    respond_to do |format|
      if @blog.save
        flash[:notice] = 'Blog was successfully created.'
        format.html { redirect_to(@blog) }
        format.js { render :partial => "block_show" }
        format.xml  { render :xml => @blog, :status => :created, :location => @blog }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.xml
  def update
    @blog = Blog.find(params[:id])
    @page = @blog.content.blocks.first.page
    @section = @page.section
    @first_post = @blog.posts.find(:first, :conditions => { :published => true }, :order => "published_on ASC" )

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        flash[:notice] = 'Blog was successfully updated.'
        format.html { redirect_to(@blog) }
        format.js { render :partial => "block_show" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.xml
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to(blogs_url) }
      format.js { render :js => "$('blog_#{params[:id]}').remove()" }
      format.xml  { head :ok }
    end
  end
end
