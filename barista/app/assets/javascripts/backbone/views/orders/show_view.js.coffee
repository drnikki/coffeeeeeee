Barista.Views.Orders ||= {}

class Barista.Views.Orders.ShowView extends Backbone.View
  template: JST["backbone/templates/orders/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
