class ContentsController < ApplicationController
  before_filter :permission, :except => :remember_text_size
  
  # GET /contents
  # GET /contents.xml
  def index
    @contents = Content.paginate( :per_page => 5, :page => params[:page] )
    
    unless params[:block_id].blank?
      @block = Block.find(params[:block_id])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @contents }
    end
  end

  # GET /contents/1
  # GET /contents/1.xml
  def show
    @content = Content.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @block = Block.find(params[:block_id])
    @content = @block.contents.build
    
    @content_controller = params[:content_controller]

    respond_to do |format|
      format.html # new.html.erb
      format.js 
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/1/edit
  def edit
    @content = Content.find(params[:id])
    
    unless params[:block_id].blank?
      @block = Block.find(params[:block_id])
    end
  end

  # POST /contents
  # POST /contents.xml
  def create
    @block = Block.find(params[:block_id])
    @content = @block.contents.build(params[:content])
    @content_controller = @content.contentable.class.to_s.tableize
    @page = @block.page
    @section = @page.section

    respond_to do |format|
      if @content.save
        flash[:notice] = 'Content was successfully created.'
        format.html { redirect_to([@section,@page]) }
        format.js do 
          if @block.parent.blank?
            render_block = @block
          else
            render_block = @block.parent
          end
          render :partial => "pages/block", :locals => { :block => render_block }
        end
        format.xml  { render :xml => @content, :status => :created, :location => @content }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contents/1
  # PUT /contents/1.xml
  def update
    @content = Content.find(params[:id])
    
    unless params[:block_id].blank?
      @block = Block.find(params[:block_id])
    end

    respond_to do |format|
      if @content.update_attributes(params[:content])
        flash[:notice] = 'Content was successfully updated.'
        format.html { redirect_to(:back) }
        format.js { render :partial => "blocks/content", :locals => { :content => @content, :parent_block => @block } }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content = Content.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js { render :js => "$('.content_#{params[:id]}').remove()" }
      format.xml  { head :ok }
    end
  end
  
  def select_type_of
    @block = Block.find(params[:block_id])
  end
  
  def remember_text_size
    session[:text_size] = params[:text_size]
    render :text => params.inspect
  end
  
end
