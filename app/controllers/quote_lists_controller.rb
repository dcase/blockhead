class QuoteListsController < ApplicationController
  before_filter :permission
  
  # GET /quote_lists
  # GET /quote_lists.xml
  def index
    @quote_lists = QuoteList.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @quote_lists }
    end
  end

  # GET /quote_lists/1
  # GET /quote_lists/1.xml
  def show
    @quote_list = QuoteList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @quote_list }
    end
  end

  # GET /quote_lists/new
  # GET /quote_lists/new.xml
  def new
    @quote_list = QuoteList.new
    @quote_list.quotes.build if @quote_list.quotes.blank?

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @quote_list }
    end
  end

  # GET /quote_lists/1/edit
  def edit
    @quote_list = QuoteList.find(params[:id])
    @quote_list.quotes.build if @quote_list.quotes.blank?
  end

  # POST /quote_lists
  # POST /quote_lists.xml
  def create
    @quote_list = QuoteList.new(params[:quote_list])

    respond_to do |format|
      if @quote_list.save
        flash[:notice] = 'QuoteList was successfully created.'
        format.html { redirect_to(@quote_list) }
        format.js { render :partial => "block_show" }
        format.xml  { render :xml => @quote_list, :status => :created, :location => @quote_list }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @quote_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quote_lists/1
  # PUT /quote_lists/1.xml
  def update
    @quote_list = QuoteList.find(params[:id])

    respond_to do |format|
      if @quote_list.update_attributes(params[:quote_list])
        flash[:notice] = 'QuoteList was successfully updated.'
        format.html { redirect_to(@quote_list) }
        format.js { render :partial => "block_show" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.html { render :action => "js" }
        format.xml  { render :xml => @quote_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quote_lists/1
  # DELETE /quote_lists/1.xml
  def destroy
    @quote_list = QuoteList.find(params[:id])
    @quote_list.destroy

    respond_to do |format|
      format.html { redirect_to(quote_lists_url) }
      format.js { render :js => "$('quote_list_#{params[:id]}').remove()" }
      format.xml  { head :ok }
    end
  end
end
