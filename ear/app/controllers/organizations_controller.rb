class OrganizationsController < ApplicationController
  # GET /Organizations
  # GET /Organizations.xml
  def index
    @Organizations = Organization.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @Organizations }
    end
  end

  # GET /Organizations/1
  # GET /Organizations/1.xml
  def show
    @Organization = Organization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @Organization }
    end
  end

  # GET /Organizations/new
  # GET /Organizations/new.xml
  def new
    @Organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @Organization }
    end
  end

  # GET /Organizations/1/edit
  def edit
    @Organization = Organization.find(params[:id])
  end

  # POST /Organizations
  # POST /Organizations.xml
  def create
    @Organization = Organization.new(params[:Organization])

    respond_to do |format|
      if @Organization.save
        format.html { redirect_to(@Organization, :notice => 'Organization was successfully created.') }
        format.xml  { render :xml => @Organization, :status => :created, :location => @Organization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @Organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Organizations/1
  # PUT /Organizations/1.xml
  def update
    @Organization = Organization.find(params[:id])

    respond_to do |format|
      if @Organization.update_attributes(params[:Organization])
        format.html { redirect_to(@Organization, :notice => 'Organization was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @Organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /Organizations/1
  # DELETE /Organizations/1.xml
  def destroy
    @Organization = Organization.find(params[:id])
    @Organization.destroy

    respond_to do |format|
      format.html { redirect_to(Organizations_url) }
      format.xml  { head :ok }
    end
  end
end
