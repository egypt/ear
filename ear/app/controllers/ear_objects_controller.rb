class EarObjectsController < ApplicationController
  # GET /ear_objects
  # GET /ear_objects.xml
  def index
    @ear_objects = EarObject.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ear_objects }
    end
  end

  # GET /ear_objects/1
  # GET /ear_objects/1.xml
  def show
    @ear_object = EarObject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ear_object }
    end
  end

  # GET /ear_objects/new
  # GET /ear_objects/new.xml
  def new
    @ear_object = EarObject.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ear_object }
    end
  end

  # GET /ear_objects/1/edit
  def edit
    @ear_object = EarObject.find(params[:id])
  end

  # POST /ear_objects
  # POST /ear_objects.xml
  def create
    @ear_object = EarObject.new(params[:ear_object])

    respond_to do |format|
      if @ear_object.save
        format.html { redirect_to(@ear_object, :notice => 'EarObject was successfully created.') }
        format.xml  { render :xml => @ear_object, :status => :created, :location => @ear_object }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ear_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ear_objects/1
  # PUT /ear_objects/1.xml
  def update
    @ear_object = EarObject.find(params[:id])

    respond_to do |format|
      if @ear_object.update_attributes(params[:ear_object])
        format.html { redirect_to(@ear_object, :notice => 'EarObject was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ear_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ear_objects/1
  # DELETE /ear_objects/1.xml
  def destroy
    @ear_object = EarObject.find(params[:id])
    @ear_object.destroy

    respond_to do |format|
      format.html { redirect_to(ear_objects_url) }
      format.xml  { head :ok }
    end
  end
end
