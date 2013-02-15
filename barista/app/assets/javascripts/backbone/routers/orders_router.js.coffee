class Barista.Routers.OrdersRouter extends Backbone.Router
  initialize: (options) ->
    @orders = new Barista.Collections.OrdersCollection()
    @orders.reset options.orders

  routes:
    "new"      : "newOrder"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newOrder: ->
    @view = new Barista.Views.Orders.NewView(collection: @orders)
    $("#orders").html(@view.render().el)

  index: ->
    @view = new Barista.Views.Orders.IndexView(orders: @orders)
    $("#orders").html(@view.render().el)

  show: (id) ->
    order = @orders.get(id)

    @view = new Barista.Views.Orders.ShowView(model: order)
    $("#orders").html(@view.render().el)

  edit: (id) ->
    order = @orders.get(id)

    @view = new Barista.Views.Orders.EditView(model: order)
    $("#orders").html(@view.render().el)
