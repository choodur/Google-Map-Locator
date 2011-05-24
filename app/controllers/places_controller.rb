class PlacesController < ApplicationController
  before_filter :get_places
  before_filter :authenticate_admin!, :except => [:index, :new, :create]
  
  def index
    @place = Place.new
    
    respond_to do |format|
      format.html
     end
  end
  
  def new
    @place = Place.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @place = Place.find params[:id]
  end
  
  def create
    @place = Place.new params[:place]
    set_status
    
    
    respond_to do |format|
      if @place.save
        flash[:notice] = "Added new place."
        format.js
        format.html { redirect_to places_path }
        
        
      else
        format.html { render :action => "new" }
        flash[:error] = "Wrong again"
        format.js
      end
    end
  end
  
  def update
    @place = Place.find(params[:id])
    set_status

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to places_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @place = Place.find params[:id]
    @place.destroy
    
    respond_to do |format|
      format.html { redirect_to places_path }
    end
    
  end

  def search
    @place = Place.find_by_name(params[:location_name])  
  end

  private
  
  def get_places
    @places = Place.approved
    @suggested = Place.suggested
  end
  
  def set_status
    @place.status = admin_signed_in? ? 'approved' : 'suggested'
  end
end
