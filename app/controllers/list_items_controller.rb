class ListItemsController < ApplicationController
  # GET /lists/new
  # GET /lists/new.xml
  def new
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.find(params[:id])
  end

  # POST /lists
  # POST /lists.xml
  def create
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.build(params[:list_item])

    respond_to do |format|
      if @list.save
        flash[:notice] = 'List was successfully created.'
        format.html { redirect_to(@list) }
        format.js { render :partial => "lists/list_item_show", :locals => { :item => @list_item, :list => @list }}
        format.xml  { render :xml => @list, :status => :created, :location => @list }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.xml
  def update
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.find(params[:id])

    respond_to do |format|
      if @list_item.update_attributes(params[:list_item])
        flash[:notice] = 'List was successfully updated.'
        format.html { redirect_to(@list) }
        format.js { render :partial => "lists/list_item_show", :locals => { :item => @list_item, :list => @list } }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.xml
  def destroy
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.find(params[:id])
    list_item_id = @list_item.id
    @list_item.destroy

    respond_to do |format|
      format.html { redirect_to(lists_url) }
      format.js { render :js => "$('#list_item_#{list_item_id}').remove()" }
      format.xml  { head :ok }
    end
  end
  
  def order
    params[:list_item].each_with_index do |id, position|
     ListItem.update(id, {:position => position+1})
    end
    render :text => params.inspect
  end
end
