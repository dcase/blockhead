class QuotesController < ApplicationController
  before_filter :permission
  
  # GET /quote_lists/new
  # GET /quote_lists/new.xml
  def new
    @quote_list = QuoteList.find(params[:quote_list_id])
    @quote = @quote_list.quotes.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @quote_list }
    end
  end

  # GET /quote_lists/1/edit
  def edit
    @quote_list = QuoteList.find(params[:quote_list_id])
    @quote = @quote_list.quotes.find(params[:id])
  end

  # POST /quote_lists
  # POST /quote_lists.xml
  def create
    @quote_list = QuoteList.find(params[:quote_list_id])
    @quote = @quote_list.quotes.build(params[:quote])

    respond_to do |format|
      if @quote_list.save
        flash[:notice] = 'QuoteList was successfully created.'
        format.html { redirect_to(@quote_list) }
        format.js { render :partial => "quote_lists/quote_show", :locals => { :quote => @quote, :quote_list => @quote_list }}
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
    @quote_list = QuoteList.find(params[:quote_list_id])
    @quote = @quote_list.quotes.find(params[:id])

    respond_to do |format|
      if @quote.update_attributes(params[:quote])
        flash[:notice] = 'QuoteList was successfully updated.'
        format.html { redirect_to(@quote_list) }
        format.js { render :partial => "quote_lists/quote_show", :locals => { :quote => @quote, :quote_list => @quote_list } }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @quote_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quote_lists/1
  # DELETE /quote_lists/1.xml
  def destroy
    @quote_list = QuoteList.find(params[:quote_list_id])
    @quote = @quote_list.quotes.find(params[:id])
    quote_id = @quote.id
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to(quote_lists_url) }
      format.js { render :js => "$('#quote_#{quote_id}').remove()" }
      format.xml  { head :ok }
    end
  end
  
  def order
    params[:quote].each_with_index do |id, position|
     Quote.update(id, {:position => position+1})
    end
    render :text => params.inspect
  end
end
