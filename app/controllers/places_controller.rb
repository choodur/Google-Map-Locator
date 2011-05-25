class PlacesController < ApplicationController
  before_filter :get_places
  before_filter :authenticate_admin!, :except => [:index, :new, :create, :search]
  
  def index
    @place = Place.new
    
    respond_to do |format|
      format.html
      format.js
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
    get_places
    
    @place.save
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @place = Place.find(params[:id])
    set_status

    respond_to do |format|
      if @place.update_attributes(params[:place])
        #format.html { redirect_to places_path }
        format.js
      else
        #format.html { render :action => "edit" }
        format.js
      end
    end
  end
  
  def destroy
    @place = Place.find params[:id]
    @place.destroy
    
    respond_to do |format|
      format.js
    end
    
  end

  def search
    @place = Place.find_by_name(params[:location_name])  
  end

  def approve
    @place = Place.find(params[:id])
    set_status
    @place.update_attributes params[:place]
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
