class PagesController < ApplicationController
  before_filter :permission, :except => :show
  
  # GET /pages
  # GET /pages.xml
  def index
    @section = Section.find(params[:section_id])
    @pages = @section.pages.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @section = Section.find(params[:section_id])
    @page = @section.pages.find(params[:id])
    
    @section_root = @section.set_root
    
    @seo_profile = @page.seo_profile || @section.seo_profile || @section_root.seo_profile

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @section = Section.find(params[:section_id])
    @page = @section.pages.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @section = Section.find(params[:section_id])
    @page = @section.pages.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @section = Section.find(params[:section_id])
    @page = @section.pages.build(params[:page])
    @block = @page.blocks.build({ :short_name => @page.short_name, :display_title => true, :css_classes => "" })

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to([@section,@page]) }
        format.js { render :partial => "common/main_menu" }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        @section = @page.section
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to([@section,@page]) }
        format.js { render :partial => "common/main_menu" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @section = Section.find(params[:section_id])
    @page = @section.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(@section) }
      format.xml  { head :ok }
    end
  end
end
