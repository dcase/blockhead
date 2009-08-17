class UsersController < ApplicationController
  before_filter :permission

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
        format.html { redirect_back_or_default account_url }
        format.js { render :partial => "user" }
      else
        format.html { render :action => :new }
        format.js { render :action => :new }
      end
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Account updated!"
        format.html { redirect_to account_url }
        format.js { render :partial => "user" }
      else
        format.html { render :action => :edit }
        format.js { render :action => :edit }
      end
    end
  end
end
