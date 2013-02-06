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
    if @order.in_queue
      # also, the order being nil could mean that it wasn't fulfilled yesterday.... so we need to check to see if it's in_queue

      #DEPRECATION WARNING: You're trying to create an attribute `queue_place'. Writing arbitrary attributes on a model is deprecated. Please just use `attr_writer` etc. (called from show at /var/www/coffee/releases/20130201212912/app/controllers/orders_controller.rb:22)
      #DEPRECATION WARNING: You're trying to create an attribute `wait_time'. Writing arbitrary attributes on a model is deprecated. Please just use `attr_writer` etc. (called from show at /var/www/coffee/releases/20130201212912/app/controllers/orders_controller.rb:23)
      @order[:queue_total] = @order.get_queue_total 
      @order[:queue_place] = @order.get_queue_place(@order)
      @order[:wait_time] = StoreConfig.find('avg_wait_time').value
    end

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
        @order[:queue_total] = @order.get_queue_total 
        @order[:queue_place] = @order.get_queue_place(@order)
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
    @orders = Order.get_queue_orders

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

end
