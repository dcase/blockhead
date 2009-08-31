class SectionsController < ApplicationController
  before_filter :permission, :except => [:show,:sitemap]
  
  # GET /sections
  # GET /sections.xml
  def index
    @sections = Section.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sections }
    end
  end

  # GET /sections/1
  # GET /sections/1.xml
  def show
    unless params[:id].blank?
      @section = Section.find(params[:id])
      redirect = true
    else
      @section = Section.find(:first, :order => :position, :conditions => { :published => true })
      redirect = false
    end
    
    @section_root = @section.set_root

    @section,@page = @section.find_first_page

    respond_to do |format|
      format.html do 
        if @page
          if redirect # only redirect if this is the home page, meaning :id is nil
            redirect_to([@section,@page])
          else
            render :controller => "pages", :action => "show", :id => @page, :section_id => @section, :template => "pages/show"
          end
        end # show.html.erb
      end
      format.xml  { render :xml => @section }
    end
  end

  # GET /sections/new
  # GET /sections/new.xml
  def new
    @section = Section.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @section }
    end
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find(params[:id])
  end

  # POST /sections
  # POST /sections.xml
  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        flash[:notice] = 'Section was successfully created.'
        format.html { redirect_to(@section) }
        format.js { render :partial => "common/main_menu" }
        format.xml  { render :xml => @section, :status => :created, :location => @section }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.xml
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Section was successfully updated.'
        format.html { redirect_to(@section) }
        format.js { render :partial => "common/main_menu" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.xml
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
  
  def order
    unless params[:section].blank?
      params[:section].each_with_index do |id, position|
       Section.update(id, {:position => position+1})
      end
    end
    unless params[:page].blank?
      params[:page].each_with_index do |id, position|
       Page.update(id, {:position => position+1})
      end
    end
   
    render :text => params.inspect
  end
  
  def sitemap
    @section = Section.new
  end

end
