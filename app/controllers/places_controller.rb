class PlacesController < ApplicationController
  
  before_filter :get_places
  
  def index
    
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
    
    respond_to do |format|
      if @place.save
        format.html { redirect_to places_path }
      else
        format.html { render :action => "new" }
        flash[:error] = "Wrong again"
      end
    end
  end
  
  def update
    @place = Place.find(params[:id])

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

  private
  
  def get_places
    @places = Place.where(["status = ?", 'approved'])
    @suggested = Place.where(["status = ?", 'suggested'])
  end
  
end
