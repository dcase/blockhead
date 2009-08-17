class BlocksController < ApplicationController
  # GET /blocks
  # GET /blocks.xml
  def index
    @page = Page.find(params[:page_id])
    @blocks = @page.blocks.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blocks }
    end
  end

  # GET /blocks/1
  # GET /blocks/1.xml
  def show
    @page = Page.find(params[:page_id])
    @block = @page.blocks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @block }
    end
  end

  # GET /blocks/new
  # GET /blocks/new.xml
  def new
    @page = Page.find(params[:page_id]) 
    @block = @page.blocks.build
    @section = @page.section
    unless params[:parent_id].blank?
      @block.parent = Block.find(params[:parent_id])
    end
    
    if defined? params[:content_controller]
      @content_controller = params[:content_controller]
    else
      @content_controller = nil
    end
    
    unless params[:add_content_id].blank?
      @content = Content.find(params[:add_content_id])
      @block.contents << @content
    end

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @block }
    end
  end

  # GET /blocks/1/edit
  def edit
    @page = Page.find(params[:page_id])
    @block = @page.blocks.find(params[:id])
    @section = @page.section
  end

  # POST /blocks
  # POST /blocks.xml
  def create
    @page = Page.find(params[:page_id]) 
    @section = @page.section
    @block = @page.blocks.build(params[:block])

    respond_to do |format|
      if @block.save
        flash[:notice] = 'Block was successfully created.'
        format.html { redirect_to([@section,@page]) }
        format.js do 
          if @block.parent.blank?
            render_block = @block
          else
            render_block = @block.parent
          end
          render :partial => "pages/block", :locals => { :block => render_block }
        end
        format.xml  { render :xml => @block, :status => :created, :location => @block }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @block.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blocks/1
  # PUT /blocks/1.xml
  def update
    @block = Block.find(params[:id])
    @page = @block.page
    @section = @page.section
    
    unless params[:block][:block_contents_attributes].blank?
      params[:block][:block_contents_attributes].delete_if do |k,v|
         v[:do_add] == "0"
      end
    end
    
    respond_to do |format|
      if @block.update_attributes(params[:block])
        flash[:notice] = 'Block was successfully updated.'
        format.html { redirect_to([@section,@page]) }
        format.js do 
          if @block.parent.blank?
            render_block = @block
          else
            render_block = @block.parent
          end
          render :partial => "pages/block", :locals => { :block => render_block }
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @block.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.xml
  def destroy
    @block = Block.find(params[:id])
    @page = @block.page
    @section = @page.section
    @block.destroy

    respond_to do |format|
      format.html { redirect_to([@section,@page]) }
      format.js { render :js => "$('.block_#{params[:id]}').remove()" }
      format.xml  { head :ok }
    end
  end
  
  def add_something
    @block = Block.find(params[:id])
    @page = @block.page
    @section = @page.section
    
    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => "add_something" }
      format.xml  { render :xml => @content }
    end
  end
  
  def remove_content
    @block = Block.find(params[:id])
    @content = Content.find(params[:content_id])
    @block_content = @block.block_contents.find(:first, :conditions => { :content_id => @content })
    @block_content.destroy
    
    respond_to do |format|
      format.js { render :js => "$('#block_#{@block.id} #content_#{@content.id}').remove()" }
    end
  end
  
  def order
    items = params[:block] || params[:tabbed_block]
    items.each_with_index do |id, position|
     Block.update(id, {:position => position+1})
    end
    render :text => params.inspect
  end

end
