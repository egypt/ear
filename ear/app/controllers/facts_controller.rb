class FactsController < ApplicationController
  # GET /facts
  # GET /facts.xml
  def index
    @facts = Fact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @facts }
    end
  end

  # GET /facts/1
  # GET /facts/1.xml
  def show
    @fact = Fact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fact }
    end
  end

  # GET /facts/new
  # GET /facts/new.xml
  def new
    @fact = Fact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fact }
    end
  end

  # GET /facts/1/edit
  def edit
    @fact = Fact.find(params[:id])
  end

  # POST /facts
  # POST /facts.xml
  def create
    @fact = Fact.new(params[:fact])

    respond_to do |format|
      if @fact.save
        format.html { redirect_to(@fact, :notice => 'Fact was successfully created.') }
        format.xml  { render :xml => @fact, :status => :created, :location => @fact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /facts/1
  # PUT /facts/1.xml
  def update
    @fact = Fact.find(params[:id])

    respond_to do |format|
      if @fact.update_attributes(params[:fact])
        format.html { redirect_to(@fact, :notice => 'Fact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /facts/1
  # DELETE /facts/1.xml
  def destroy
    @fact = Fact.find(params[:id])
    @fact.destroy

    respond_to do |format|
      format.html { redirect_to(facts_url) }
      format.xml  { head :ok }
    end
  end
end
