class MapsController < ApplicationController

  # GET /maps
  def index
	  m = Map.new()
	  @map = m.map_all_devices
	  respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosts }
    end
  end
  
  # GET /map/1
  # GET /map/1.xml
  def show
	  m = Map.new()
	  @map = m.map_single_device(params[:id])
	  
	  respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

end
