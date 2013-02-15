Barista.Views.Orders ||= {}

class Barista.Views.Orders.EditView extends Backbone.View
  template: JST["backbone/templates/orders/edit"]

  events:
    "submit #edit-order": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (order) =>
        @model = order
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
