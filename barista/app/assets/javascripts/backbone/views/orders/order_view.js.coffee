Barista.Views.Orders ||= {}

class Barista.Views.Orders.OrderView extends Backbone.View
  template: JST["backbone/templates/orders/order"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
