class SeoProfilesController < ApplicationController
  before_filter :require_user, :permission
  # GET /seo_profiles
  # GET /seo_profiles.xml
  def index
    @seo_profiles = SeoProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @seo_profiles }
    end
  end

  # GET /seo_profiles/1
  # GET /seo_profiles/1.xml
  def show
    @seo_profile = SeoProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @seo_profile }
    end
  end

  # GET /seo_profiles/new
  # GET /seo_profiles/new.xml
  def new
    @seo_profile = SeoProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @seo_profile }
    end
  end

  # GET /seo_profiles/1/edit
  def edit
    @seo_profile = SeoProfile.find(params[:id])
  end

  # POST /seo_profiles
  # POST /seo_profiles.xml
  def create
    @seo_profile = SeoProfile.new(params[:seo_profile])

    respond_to do |format|
      if @seo_profile.save
        flash[:notice] = 'SeoProfile was successfully created.'
        format.html { redirect_to(@seo_profile) }
        format.js { render :partial => 'seo_profile', :locals => { :seo_profile => @seo_profile } }
        format.xml  { render :xml => @seo_profile, :status => :created, :location => @seo_profile }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @seo_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /seo_profiles/1
  # PUT /seo_profiles/1.xml
  def update
    @seo_profile = SeoProfile.find(params[:id])

    respond_to do |format|
      if @seo_profile.update_attributes(params[:seo_profile])
        flash[:notice] = 'SeoProfile was successfully updated.'
        format.html { redirect_to(@seo_profile) }
        format.js { render :partial => 'seo_profile', :locals => { :seo_profile => @seo_profile } }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit" }
        format.xml  { render :xml => @seo_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /seo_profiles/1
  # DELETE /seo_profiles/1.xml
  def destroy
    @seo_profile = SeoProfile.find(params[:id])
    @seo_profile.destroy

    respond_to do |format|
      format.html { redirect_to(seo_profiles_url) }
      format.js { render :js => "$('#seo_profile_" + @seo_profile.id.to_s + "').remove()" }
      format.xml  { head :ok }
    end
  end
end
