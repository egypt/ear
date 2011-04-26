class DevicesController < ApplicationController

  # GET /Devices
  # GET /Devices.xml
  def index
    @Devices = Device.find(:all, :order => sort_order(params[:order] || 'updated_at'))
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @Devices }
    end
  end

  # GET /Devices/1
  # GET /Devices/1.xml
  def show
    @Device = Device.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @Device }
    end

  end

  # GET /Devices/new
  # GET /Devices/new.xml
  def new
    @Device = Device.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @Device }
    end
  end

  # GET /Devices/1/edit
  def edit
    @Device = Device.find(params[:id])
  end

  # POST /Devices
  # POST /Devices.xml
  def create
    @Device = Device.new(params[:Device])

    respond_to do |format|
      if @Device.save
        format.html { redirect_to(@Device, :notice => 'Device was successfully created.') }
        format.xml  { render :xml => @Device, :status => :created }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @Device.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Devices/1
  # PUT /Devices/1.xml
  def update
    @Device = Device.find(params[:id])

    respond_to do |format|
      if @Device.update_attributes(params[:Device])
        format.html { redirect_to(@Device, :notice => 'Device was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @Device.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /Devices/1
  # DELETE /Devices/1.xml
  def destroy
    @Device = Device.find(params[:id])
    @Device.destroy

    respond_to do |format|
      format.html { redirect_to(Devices_url) }
      format.xml  { head :ok }
    end
  end
end
