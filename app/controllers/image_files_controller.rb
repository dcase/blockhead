class ImageFilesController < ApplicationController
  before_filter :permission
  
  # GET /image_files
  # GET /image_files.xml
  def index
    @image_files = ImageFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @image_files }
    end
  end

  # GET /image_files/1
  # GET /image_files/1.xml
  def show
    @image_file = ImageFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @image_file }
    end
  end

  # GET /image_files/new
  # GET /image_files/new.xml
  def new
    @image_file = ImageFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @image_file }
    end
  end

  # GET /image_files/1/edit
  def edit
    @image_file = ImageFile.find(params[:id])
  end

  # POST /image_files
  # POST /image_files.xml
  def create
    @image_file = ImageFile.new(params[:image_file])

    respond_to do |format|
      if @image_file.save
        flash[:notice] = 'ImageFile was successfully created.'
        format.html { redirect_to(@image_file) }
        format.js do
          responds_to_parent do
            render :js => "tabs.tabs('url',0,'" + url_for( :controller => "image_files", :action => "insert", :id => @image_file) + "');tabs.tabs('select',0);"
            debugger
          end
        end
        format.xml  { render :xml => @image_file, :status => :created, :location => @image_file }
      else
        format.html { render :action => "new" }
        format.js do 
          responds_to_parent do
            render :action => "new"
          end
        end
        format.xml  { render :xml => @image_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /image_files/1
  # PUT /image_files/1.xml
  def update
    @image_file = ImageFile.find(params[:id])

    respond_to do |format|
      if @image_file.update_attributes(params[:image_file])
        flash[:notice] = 'ImageFile was successfully updated.'
        format.html { redirect_to(@image_file) }
        format.js do 
          responds_to_parent do
            render :action => "index"
          end
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js do 
          responds_to_parent do 
            render :action => "edit"
          end
        end
        format.xml  { render :xml => @image_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /image_files/1
  # DELETE /image_files/1.xml
  def destroy
    @image_file = ImageFile.find(params[:id])
    @image_file.destroy

    respond_to do |format|
      format.html { redirect_to(image_files_url) }
      format.js { render :js => "$('#image_file_#{params[:id]}').remove();"}
      format.xml  { head :ok }
    end
  end
  
  def manage
    @image_files = ImageFile.all
  end
  
  def insert
    unless params[:id].blank?
      @image_file = ImageFile.find(params[:id])
    else
      @image_file = ImageFile.new
    end
  
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @image_file }
    end
  end
end
