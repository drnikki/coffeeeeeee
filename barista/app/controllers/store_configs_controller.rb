class StoreConfigsController < ApplicationController
  # GET /store_configs
  # GET /store_configs.json
  def index
    @store_configs = StoreConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @store_configs }
    end
  end

  # GET /store_configs/[name]
  # GET /store_configs/[name].json
  def show
    @store_config = StoreConfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store_config }
    end
  end

  # GET /store_configs/new
  # GET /store_configs/new.json
  def new
    @store_config = StoreConfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @store_config }
    end
  end

  # GET /store_configs/1/edit
  def edit
    @store_config = StoreConfig.find(params[:id])
  end

  # POST /store_configs
  # POST /store_configs.json
  def create
    @store_config = StoreConfig.new(params[:store_config])

    respond_to do |format|
      if @store_config.save
        format.html { redirect_to @store_config, notice: 'Store config was successfully created.' }
        format.json { render json: @store_config, status: :created, location: @store_config }
      else
        format.html { render action: "new" }
        format.json { render json: @store_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /store_configs/1
  # PUT /store_configs/1.json
  def update
    @store_config = StoreConfig.find(params[:id])

    respond_to do |format|
      if @store_config.update_attributes(params[:store_config])
        format.html { redirect_to @store_config, notice: 'Store config was successfully updated.' }
        format.json { render json: @store_config, status: :created, location: @store_config }
      else
        format.html { render action: "edit" }
        format.json { render json: @store_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_configs/1
  # DELETE /store_configs/1.json
  def destroy
    @store_config = StoreConfig.find(params[:id])
    @store_config.destroy

    respond_to do |format|
      format.html { redirect_to store_configs_url }
      format.json { head :no_content }
    end
  end
end
