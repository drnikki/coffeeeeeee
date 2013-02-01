class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    # if the order is incomplete, we need to return the order's
    # place in the queue and the approximate wait time.
    # adding one to this so it's not zero based, for the people.
     @order[:queue_place] = Order.where('fulfilled IS NULL AND placed < ?', @order.placed).count + 1
     @order[:wait_time] = StoreConfig.find('avg_wait_time').value

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        # brb WET code.
        @order[:queue_place] = Order.where('fulfilled IS NULL AND placed < ?', @order.placed).count + 1
        @order[:wait_time] = StoreConfig.find('avg_wait_time').value
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  # helper for fulfilling an order
  # GET /orders/1/complete.json
  def complete
    @order = Order.find(params[:id])
    @order.update_attributes(:fulfilled => Time.now)

    respond_to do |format|
      if @order.update_attributes(:fulfilled => Time.now)
        format.html { redirect_to @order, notice: 'Order was successfully completed.' }
        format.json { render json: @order, status: :updated }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

  end

  # GET /queue
  # GET /queue.json
  def queue
    # yesterday's undone orders will still have fulfilled = NULL
    @orders = Order.where('fulfilled IS NULL AND created_at > ?', Time.zone.now.beginning_of_day)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

end
