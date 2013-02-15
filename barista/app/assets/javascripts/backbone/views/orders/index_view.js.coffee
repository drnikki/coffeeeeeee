Barista.Views.Orders ||= {}

class Barista.Views.Orders.IndexView extends Backbone.View
  template: JST["backbone/templates/orders/index"]

  initialize: () ->
    @options.orders.bind('reset', @addAll)

  addAll: () =>
    @options.orders.each(@addOne)

  addOne: (order) =>
    view = new Barista.Views.Orders.OrderView({model : order})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template(orders: @options.orders.toJSON() ))
    @addAll()

    return this
