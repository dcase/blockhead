class UsersController < ApplicationController
  before_filter :permission
  before_filter :admin_only, :only => :index
  
  def index
    @users = User.paginate( :per_page => 10, :page => params[:page] )
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @users }
    end
  end

  def new
    @user = User.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        flash[:notice] = "Account registered!"
        format.html { redirect_to :back }
        format.js { render :partial => "user_row", :locals => { :user => @user } }
      else
        format.html { render :action => :new }
        format.js { render :action => :new }
      end
    end
  end

  def show
    @user = User.find(params[:id]) || @current_user
  end

  def edit
    @user = User.find(params[:id]) || @current_user
  end

  def update
    @user = User.find(params[:id]) || @current_user # makes our views "cleaner" and more consistent
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Account updated!"
        format.html { redirect_to account_url }
        format.js do 
          if @user.edit_self == "true"
            render :partial => "user", :locals => { :user => @user }
          else
            render :partial => "user_row", :locals => { :user => @user }
          end
        end
      else
        format.html { render :action => :edit }
        format.js { render :action => :edit }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js { render :js => "$('#user_#{params[:id]}').remove()" }
      format.xml  { head :ok }
    end
  end
  
end
