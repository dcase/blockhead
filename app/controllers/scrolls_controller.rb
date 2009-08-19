class ScrollsController < ApplicationController
  before_filter :permission
  
  # GET /scrolls
  # GET /scrolls.xml
  def index
    @scrolls = Scroll.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scrolls }
    end
  end

  # GET /scrolls/1
  # GET /scrolls/1.xml
  def show
    @scroll = Scroll.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scroll }
    end
  end

  # GET /scrolls/new
  # GET /scrolls/new.xml
  def new
    @scroll = Scroll.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scroll }
    end
  end

  # GET /scrolls/1/edit
  def edit
    @scroll = Scroll.find(params[:id])
  end

  # POST /scrolls
  # POST /scrolls.xml
  def create
    @scroll = Scroll.new(params[:scroll])

    respond_to do |format|
      if @scroll.save
        flash[:notice] = 'Scroll was successfully created.'
        format.html { redirect_to(@scroll) }
        format.xml  { render :xml => @scroll, :status => :created, :location => @scroll }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scroll.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scrolls/1
  # PUT /scrolls/1.xml
  def update
    @scroll = Scroll.find(params[:id])

    respond_to do |format|
      if @scroll.update_attributes(params[:scroll])
        flash[:notice] = 'Scroll was successfully updated.'
        format.html { redirect_to(@scroll) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @scroll.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scrolls/1
  # DELETE /scrolls/1.xml
  def destroy
    @scroll = Scroll.find(params[:id])
    @scroll.destroy

    respond_to do |format|
      format.html { redirect_to(scrolls_url) }
      format.xml  { head :ok }
    end
  end
end
