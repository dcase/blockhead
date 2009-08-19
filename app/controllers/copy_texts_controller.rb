class CopyTextsController < ApplicationController
  before_filter :permission
  
  # GET /copy_texts
  # GET /copy_texts.xml
  def index
    @copy_texts = CopyText.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @copy_texts }
    end
  end

  # GET /copy_texts/1
  # GET /copy_texts/1.xml
  def show
    @copy_text = CopyText.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @copy_text }
    end
  end

  # GET /copy_texts/new
  # GET /copy_texts/new.xml
  def new
    @copy_text = CopyText.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @copy_text }
    end
  end

  # GET /copy_texts/1/edit
  def edit
    @copy_text = CopyText.find(params[:id])
  end

  # POST /copy_texts
  # POST /copy_texts.xml
  def create
    @copy_text = CopyText.new(params[:copy_text])

    respond_to do |format|
      if @copy_text.save
        flash[:notice] = 'CopyText was successfully created.'
        format.html { redirect_to(@copy_text) }
        format.xml  { render :xml => @copy_text, :status => :created, :location => @copy_text }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @copy_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /copy_texts/1
  # PUT /copy_texts/1.xml
  def update
    @copy_text = CopyText.find(params[:id])

    respond_to do |format|
      if @copy_text.update_attributes(params[:copy_text])
        flash[:notice] = 'CopyText was successfully updated.'
        format.html { redirect_to(@copy_text) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @copy_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /copy_texts/1
  # DELETE /copy_texts/1.xml
  def destroy
    @copy_text = CopyText.find(params[:id])
    @copy_text.destroy

    respond_to do |format|
      format.html { redirect_to(copy_texts_url) }
      format.xml  { head :ok }
    end
  end
end
