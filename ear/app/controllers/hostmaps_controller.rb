class HostmapsController < ApplicationController

  # GET /hostsmap
  def index
	h = Hostmap.new()
	@map = h.map_all
  end
  
  
   # GET /hostmap/1
  # GET /hostmap/1.xml
  def show
	h = Hostmap.new()
	@map = h.map_single(params[:id])
  end

end
