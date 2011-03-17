class MapsController < ApplicationController

  # GET /maps
  def index
	  m = Map.new()
	  @map = m.map_all_hosts
	  respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosts }
    end
  end
  
  # GET /map/1
  # GET /map/1.xml
  def show
	  m = Map.new()
	  @map = m.map_single_host(params[:id])
	  
	  respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

end
